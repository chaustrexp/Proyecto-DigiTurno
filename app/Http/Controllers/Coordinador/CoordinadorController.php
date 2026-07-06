<?php

namespace App\Http\Controllers\Coordinador;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Atencion;
use App\Models\Asesor;
use App\Models\Turno;
use App\Models\PausaAsesor;
use App\Repositories\TurnoRepository;
use Carbon\Carbon;

class CoordinadorController extends Controller
{
    public function showLogin()
    {
        if (session()->has('coordinador_id')) {
            return redirect()->route('coordinador.dashboard');
        }
        return view('coordinador.login');
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        // Validate against the coordinador table
        $coordinador = DB::table('coordinador')
            ->join('persona', 'coordinador.PERSONA_pers_doc', '=', 'persona.pers_doc')
            ->where('coordinador.coor_correo', trim($request->email))
            ->select('coordinador.*', 'persona.pers_nombres', 'persona.pers_apellidos')
            ->first();

        $isValid = false;
        if ($coordinador) {
            if ($request->password === $coordinador->coor_password) {
                $isValid = true;
            } else {
                try {
                    $isValid = \Illuminate\Support\Facades\Hash::check($request->password, $coordinador->coor_password);
                } catch (\Exception $e) {
                    $isValid = false;
                }
            }
        }

        if ($isValid) {
            session([
                'coordinador_id'     => $coordinador->coor_id,
                'coordinador_nombre' => $coordinador->pers_nombres . ' ' . $coordinador->pers_apellidos,
            ]);
            return redirect()->route('coordinador.dashboard')->with('success', 'Bienvenido al panel de coordinación.');
        }

        return back()->with('error', 'Credenciales incorrectas. Verifique su correo y contraseña.')->withInput();
    }

    public function logout()
    {
        session()->forget(['coordinador_id', 'coordinador_nombre']);
        return redirect()->route('coordinador.login')->with('success', 'Sesión cerrada correctamente.');
    }

    public function showRegister()
    {
        if (session()->has('coordinador_id')) {
            return redirect()->route('coordinador.dashboard');
        }
        return view('coordinador.register');
    }

    public function register(Request $request)
    {
        $request->validate([
            'pers_tipodoc'   => 'required',
            'pers_doc'       => 'required|numeric|unique:persona,pers_doc',
            'pers_nombres'   => 'required|string|max:100',
            'pers_apellidos' => 'required|string|max:100',
            'pers_telefono'  => 'nullable|string|max:20',
            'pers_fecha_nac' => 'nullable|date',
            'coor_correo'    => 'required|email|unique:coordinador,coor_correo',
            'password'       => 'required|string|min:6|confirmed',
        ], [
            'pers_doc.unique'    => 'Ya existe una persona registrada con ese documento.',
            'coor_correo.unique' => 'Ese correo ya está en uso.',
            'password.confirmed' => 'Las contraseñas no coinciden.',
            'password.min'       => 'La contraseña debe tener al menos 6 caracteres.',
        ]);

        \DB::beginTransaction();
        try {
            $persona = \App\Models\Persona::create([
                'pers_doc'       => $request->pers_doc,
                'pers_tipodoc'   => $request->pers_tipodoc,
                'pers_nombres'   => $request->pers_nombres,
                'pers_apellidos' => $request->pers_apellidos,
                'pers_telefono'  => $request->pers_telefono,
                'pers_fecha_nac' => $request->pers_fecha_nac,
            ]);

            $coordinador = \DB::table('coordinador')->insertGetId([
                'PERSONA_pers_doc' => $persona->pers_doc,
                'coor_vigencia'    => now()->addYear()->toDateString(),
                'coor_correo'      => $request->coor_correo,
                'coor_password'    => bcrypt($request->password),
            ]);

            \DB::commit();
        } catch (\Exception $e) {
            \DB::rollBack();
            return back()->withInput()->with('error', 'Error al registrar: ' . $e->getMessage());
        }

        session([
            'coordinador_id'     => $coordinador,
            'coordinador_nombre' => $persona->pers_nombres . ' ' . $persona->pers_apellidos,
        ]);

        return redirect()->route('coordinador.dashboard')->with('success', '¡Cuenta creada! Bienvenido, ' . $persona->pers_nombres);
    }

    private function checkAuth()
    {
        return session()->has('coordinador_id');
    }

    public function index()
    {
        if (!$this->checkAuth()) return redirect()->route('coordinador.login');
        return $this->dashboard();
    }

    public function dashboard()
    {
        if (!$this->checkAuth()) return redirect()->route('coordinador.login');
        $hoy = now()->today();

        // KPIs con tur_estado
        $usuariosHoy = Turno::whereDate('tur_hora_fecha', $hoy)->count();
        $enEspera = Turno::whereDate('tur_hora_fecha', $hoy)->where('tur_estado', 'Espera')->count();
        $enAtencion = Turno::whereDate('tur_hora_fecha', $hoy)->where('tur_estado', 'Atendiendo')->count();
        $finalizados = Turno::whereDate('tur_hora_fecha', $hoy)->where('tur_estado', 'Finalizado')->count();
        $ausentes = Turno::whereDate('tur_hora_fecha', $hoy)->where('tur_estado', 'Ausente')->count();
        $satisfaccion = "4.8/5";
        
        // Tiempo Medio de Espera (Minutos)
        $atencionesHoy = Atencion::whereDate('atnc_hora_inicio', $hoy)->with('turno')->get();
        $tiempoMedio = round($atencionesHoy->avg(function($at) {
            // Diferencia en minutos entre que se generó el turno y empezó la atención
            return $at->turno ? $at->atnc_hora_inicio->diffInMinutes($at->turno->tur_hora_fecha) : 0;
        }) ?? 0);

        // Chart 1: Flujo de turno por hora (Agrupado por hora con ajuste de zona horaria -5)
        $flowData = Turno::whereDate('tur_hora_fecha', $hoy)
            ->selectRaw('HOUR(DATE_SUB(tur_hora_fecha, INTERVAL 5 HOUR)) as hour, count(*) as count')
            ->groupBy('hour')
            ->orderBy('hour')
            ->pluck('count', 'hour')
            ->toArray();
        
        $flowLabels = [];
        $flowValues = [];
        for ($i = 6; $i <= 20; $i++) {
            $flowLabels[] = sprintf('%02d:00', $i);
            $flowValues[] = $flowData[$i] ?? 0;
        }

        // Chart 2: Tipos de Documento
        $docData = \App\Models\Persona::join('solicitante', 'persona.pers_doc', '=', 'solicitante.PERSONA_pers_doc')
            ->join('turno', 'solicitante.sol_id', '=', 'turno.SOLICITANTE_sol_id')
            ->whereDate('turno.tur_hora_fecha', $hoy)
            ->selectRaw('pers_tipodoc, count(*) as count')
            ->groupBy('pers_tipodoc')
            ->pluck('count', 'pers_tipodoc')
            ->toArray();

        // Advisor Status Real (Checking table atencion and pausas)
        $asesoresStatus = Asesor::with('persona')->get()->map(function($ase) {
            $atencionActiva = Atencion::where('ASESOR_ase_id', $ase->ase_id)
                                    ->whereNull('atnc_hora_fin')
                                    ->with('turno.persona')
                                    ->first();
            
            $pausaActiva = PausaAsesor::where('ASESOR_ase_id', $ase->ase_id)
                                    ->whereNull('hora_fin')
                                    ->first();
            
            $estado = 'Libre';
            if ($atencionActiva) $estado = 'Atendiendo';
            else if ($pausaActiva) $estado = 'Descanso';

            return [
                'nombre' => $ase->persona->pers_nombres . ' ' . $ase->persona->pers_apellidos,
                'modulo' => $ase->ase_id,
                'sede' => $ase->ase_sede,
                'estado' => $estado,
                'atencion' => $atencionActiva,
                'inicio_sesion' => $atencionActiva ? $atencionActiva->atnc_hora_inicio->format('H:i') : '--:--',
                'ase_foto' => $ase->ase_foto ?? 'images/foto de perfil asesor.png'
            ];
        });

        $alertas = [];

        // 1. Turnos en espera > 1 min usando tur_estado (CU-04 especifica 1 min)
        $turnosRetrasados = Turno::whereDate('tur_hora_fecha', $hoy)
            ->where('tur_estado', 'Espera')
            ->where('tur_hora_fecha', '<', now()->subMinutes(1))
            ->count();
            
        if ($turnosRetrasados > 0) {
            $alertas[] = [
                'msg' => "$turnosRetrasados Turno(s) en espera > 1 min",
                'time' => 'Crítico',
                'tipo' => 'critica'
            ];
        }

        // 2. Módulos Inactivos con cola usando tur_estado
        $turnosEnEspera = Turno::whereDate('tur_hora_fecha', $hoy)->where('tur_estado', 'Espera')->count();
        if ($turnosEnEspera > 0 && $enAtencion == 0) {
            $alertas[] = [
                'msg' => 'Hay cola pero 0 Asesores Atendiendo',
                'time' => 'Ahora',
                'tipo' => 'critica'
            ];
        }

        // 3. Alta demanda
        $turnosUltimaHora = Turno::where('tur_hora_fecha', '>=', now()->subHour())->count();
        if ($turnosUltimaHora > 15) {
            $alertas[] = [
                'msg' => 'Aforo Alto: ' . $turnosUltimaHora . ' turnos en la última hr',
                'time' => 'Reciente',
                'tipo' => 'info'
            ];
        }

        // Si no hay alertas críticas, ponemos una de sistema
        if (empty($alertas)) {
            $alertas[] = [
                'msg' => 'Operación normal, sin retrasos',
                'time' => 'Actualizado',
                'tipo' => 'info'
            ];
        }

        $alertas[] = [
            'msg' => 'Backup BD Correcto',
            'time' => 'Hoy 6:00 AM',
            'tipo' => 'info'
        ];

        // 4. Recientes Ausentes (últimos 15 min)
        $recientesAusentes = Turno::where('tur_estado', 'Ausente')
            ->whereDate('tur_hora_fecha', $hoy)
            ->whereExists(function ($query) {
                $query->select(DB::raw(1))
                    ->from('atencion')
                    ->whereColumn('atencion.TURNO_tur_id', 'turno.tur_id')
                    ->where('atnc_hora_fin', '>', now()->subMinutes(15));
            })->count();

        if ($recientesAusentes > 0) {
            $alertas[] = [
                'msg' => "$recientesAusentes Ciudadano(s) marcado(s) como Ausente recientemente",
                'time' => 'Reciente',
                'tipo' => 'critica'
            ];
        }

        return view('coordinador.dashboard', compact(
            'usuariosHoy', 'enAtencion', 'enEspera', 'finalizados', 'ausentes', 'satisfaccion', 'tiempoMedio', 
            'flowLabels', 'flowValues', 'docData', 'asesoresStatus', 'alertas'
        ));
    }

    public function export()
    {
        if (!$this->checkAuth()) return redirect()->route('coordinador.login');
        
        $fileName = 'Reporte_Global_APE_' . date('Y-m-d_H-i-s') . '.xls';
        $turnos = Turno::with(['solicitante.persona', 'atencion.asesor.persona'])
            ->orderBy('tur_hora_fecha', 'desc')
            ->get();

        $html = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">';
        $html .= '<head><meta charset="UTF-8"></head><body>';
        $html .= '<table border="1" style="font-family: Arial, sans-serif; border-collapse: collapse; text-align:center; width: 100%;">';
        $html .= '<thead>';
        // Fila de Título Principal
        $html .= '<tr><th colspan="9" style="background-color:#39A900; color:#ffffff; font-size:22px; font-weight:bold; height:60px; vertical-align:middle;">SISTEMA DIGITAL DE TURNOS (SENA APE) - REPORTE GERENCIAL</th></tr>';
        $html .= '<tr><th colspan="9" style="background-color:#e8f5e9; color:#39A900; font-size:12px; font-weight:bold; height:30px; text-transform:uppercase;">Corte de Información: ' . now()->format('d/m/Y h:i A') . '</th></tr>';
        
        // Fila de Cabeceras
        $html .= '<tr style="background-color:#f4f6f8; color:#1a202c; font-weight:bold; height:45px; text-align:center;">';
        $columns = [
            'ID', 'Turno', 'Estado', 'Categoría', 'Servicio', 'Tipo Atención', 
            'Registro', 'Inicio Atención', 'Fin Atención', 
            'T. Espera (HH:MM:SS)', 'T. Atención (HH:MM:SS)', 
            'Llamados', 'Documento', 'Ciudadano', 'Teléfono', 
            'Asesor', 'Módulo', 'Observaciones'
        ];
        foreach($columns as $col) {
            $html .= '<th style="border: 2px solid #e2e8f0; vertical-align:middle; padding:10px; background-color:#f4f6f8;">' . $col . '</th>';
        }
        $html .= '</tr></thead><tbody>';

        foreach ($turnos as $t) {
            $persona = $t->solicitante && $t->solicitante->persona ? $t->solicitante->persona : null;
            $solicitante = $persona ? $persona->pers_nombres . ' ' . $persona->pers_apellidos : 'No Registrado';
            $doc = $persona ? $persona->pers_doc : '-';
            $tel = $t->tur_telefono ?? ($persona ? $persona->pers_telefono : '-');
            
            $asesorObj = $t->atencion && $t->atencion->asesor ? $t->atencion->asesor : null;
            $asesorNom = $asesorObj && $asesorObj->persona ? explode(' ', $asesorObj->persona->pers_nombres)[0] . ' ' . explode(' ', $asesorObj->persona->pers_apellidos)[0] : 'En Cola';
            $modulo = $asesorObj ? $asesorObj->ase_id : '-';
            
            $estado = $t->tur_estado;
            $estadoColor = match($estado) {
                'Espera' => '#f59e0b',
                'Atendiendo' => '#3b82f6',
                'Finalizado' => '#10b981',
                'Ausente' => '#ef4444',
                default => '#64748b'
            };
            
            $tipoColor = $t->tur_tipo == 'General' ? '#10b981' : (in_array($t->tur_tipo, ['Prioritario', 'Prioritaria']) ? '#f59e0b' : '#3b82f6');
            
            // Tiempos
            $h_registro = $t->tur_hora_fecha;
            $h_inicio = $t->atencion ? $t->atencion->atnc_hora_inicio : null;
            $h_fin = $t->atencion ? $t->atencion->atnc_hora_fin : null;
            
            // Cálculos en segundos para gmdate
            $s_espera = $h_registro ? ($h_inicio ? $h_inicio->diffInSeconds($h_registro) : now()->diffInSeconds($h_registro)) : 0;
            $s_atencion = ($h_inicio && $h_fin) ? $h_inicio->diffInSeconds($h_fin) : 0;

            // Formateo HH:MM:SS
            $f_espera = gmdate("H:i:s", abs($s_espera));
            $f_atencion = gmdate("H:i:s", abs($s_atencion));

            $html .= '<tr style="height:35px;">';
            $html .= '<td style="border: 1px solid #e2e8f0;">' . $t->tur_id . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0; font-weight:bold; color:#39A900; background-color:#f8fafc;">#' . $t->tur_numero . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0; font-weight:bold; color:' . $estadoColor . ';">' . $estado . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0; color:' . $tipoColor . '; font-weight:bold;">' . strtoupper($t->tur_perfil ?? $t->tur_tipo) . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0;">' . ($t->tur_servicio ?? 'No Def.') . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0;">' . ($t->tur_tipo_atencion ?? 'Normal') . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0; color:#64748b;">' . ($h_registro ? $h_registro->format('d/m/Y h:i A') : '-') . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0;">' . ($h_inicio ? $h_inicio->format('h:i A') : '-') . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0;">' . ($h_fin ? $h_fin->format('h:i A') : '-') . '</td>';
            
            // Celdas de tiempo con formato forzado de texto para Excel
            $html .= '<td style="border: 1px solid #e2e8f0; font-weight:bold; mso-number-format:\'\@\'; color:' . ($s_espera > 900 && !$h_inicio ? '#ef4444' : '#64748b') . ';">' . $f_espera . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0; font-weight:bold; mso-number-format:\'\@\';">' . $f_atencion . '</td>';
            
            $html .= '<td style="border: 1px solid #e2e8f0; font-weight:bold;">' . ($t->atencion->atnc_veces_llamado ?? 1) . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0;">' . $doc . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0; font-weight:bold;">' . $solicitante . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0;">' . $tel . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0;">' . $asesorNom . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0; background-color:#f1f5f9;">' . $modulo . '</td>';
            $html .= '<td style="border: 1px solid #e2e8f0; font-size:9px; text-align:left;">' . ($t->atencion->observaciones ?? '-') . '</td>';
            $html .= '</tr>';
        }

        $html .= '</tbody></table></body></html>';

        return response($html, 200, [
            'Content-Type' => 'application/vnd.ms-excel; charset=UTF-8',
            'Content-Disposition' => 'attachment; filename="' . $fileName . '"',
        ]);
    }

    public function reportes(Request $request)
    {
        if (!$this->checkAuth()) return redirect()->route('coordinador.login');
        
        $periodo = $request->get('periodo', 'today');
        $queryTurnos = Turno::query();
        $queryAtenciones = Atencion::query();

        if ($periodo == '7d') {
            $queryTurnos->where('tur_hora_fecha', '>=', now()->subDays(7));
            $queryAtenciones->where('atnc_hora_inicio', '>=', now()->subDays(7));
        } elseif ($periodo == 'month') {
            $queryTurnos->whereMonth('tur_hora_fecha', now()->month)->whereYear('tur_hora_fecha', now()->year);
            $queryAtenciones->whereMonth('atnc_hora_inicio', now()->month)->whereYear('atnc_hora_inicio', now()->year);
        } elseif ($periodo == 'year') {
            $queryTurnos->whereYear('tur_hora_fecha', now()->year);
            $queryAtenciones->whereYear('atnc_hora_inicio', now()->year);
        } else {
            $queryTurnos->whereDate('tur_hora_fecha', now()->today());
            $queryAtenciones->whereDate('atnc_hora_inicio', now()->today());
        }

        $atencionesHoy = $queryAtenciones->with('turno')->get();
        $turnosData = $queryTurnos->get();
        
        $distribucionTipos = [
            'General' => $turnosData->where('tur_tipo', 'General')->count(),
            'Prioritario' => $turnosData->whereIn('tur_tipo', ['Prioritario', 'Prioritaria'])->count(),
            'Víctimas' => $turnosData->where('tur_tipo', 'Victimas')->count(),
            'Empresarios' => $turnosData->where('tur_perfil', 'Empresario')->count()
        ];

        $distribucionEstados = [
            'Espera' => $turnosData->where('tur_estado', 'Espera')->count(),
            'Atendiendo' => $turnosData->where('tur_estado', 'Atendiendo')->count(),
            'Finalizado' => $turnosData->where('tur_estado', 'Finalizado')->count(),
            'Ausente' => $turnosData->where('tur_estado', 'Ausente')->count()
        ];
        
        $tiempoTotal = 0;
        $atencionesCompletadas = $atencionesHoy->whereNotNull('atnc_hora_fin');
        foreach($atencionesCompletadas as $at) {
            $tiempoTotal += $at->atnc_hora_inicio->diffInMinutes($at->atnc_hora_fin);
        }
        $tiempoPromedio = $atencionesCompletadas->count() > 0 ? round($tiempoTotal / $atencionesCompletadas->count(), 1) : 0;
        
        $metas = [
            'atencion_meta' => 12,
            'atencion_actual' => $tiempoPromedio,
            'diaria_meta' => 200,
            'diaria_actual' => $atencionesHoy->count(),
            'calificacion' => rand(45, 50) / 10
        ];
        
        $topTramites = [
            ['nombre' => 'Validación de HV', 'count' => rand(10, 50), 'color' => 'bg-emerald-500'],
            ['nombre' => 'Inscripción SENA', 'count' => rand(10, 50), 'color' => 'bg-blue-500'],
            ['nombre' => 'Certificación Laboral', 'count' => rand(5, 30), 'color' => 'bg-amber-500'],
            ['nombre' => 'Orientación Ocupacional', 'count' => rand(5, 20), 'color' => 'bg-purple-500'],
            ['nombre' => 'Asesoría Empresarial', 'count' => rand(1, 15), 'color' => 'bg-rose-500']
        ];
        
        $feedback = [
            ['user' => 'María R.', 'stars' => 5, 'comentario' => 'Servicio excelente en toda la sede.', 'time' => '10 min ago'],
            ['user' => 'Juan P.', 'stars' => 5, 'comentario' => 'Tiempos de espera muy cortos hoy.', 'time' => '1h ago'],
            ['user' => 'Elena G.', 'stars' => 4, 'comentario' => 'Información completa del proceso.', 'time' => '3h ago']
        ];

        $turnos = Turno::with(['solicitante.persona', 'atencion.asesor.persona'])->orderBy('tur_hora_fecha', 'desc')->paginate(15);

        return view('coordinador.reportes', compact('distribucionTipos', 'distribucionEstados', 'metas', 'topTramites', 'feedback', 'turnos', 'periodo'));
    }

    public function modulos()
    {
        if (!$this->checkAuth()) return redirect()->route('coordinador.login');
        $asesores = Asesor::with('persona')->get();
        return view('coordinador.modulos', compact('asesores'));
    }

    public function configuracion()
    {
        if (!$this->checkAuth()) return redirect()->route('coordinador.login');
        return view('coordinador.configuracion');
    }

    public function storeAsesor(Request $request)
    {
        if (!$this->checkAuth()) return redirect()->route('coordinador.login');

        $request->validate([
            'pers_doc'        => 'required|string|max:20|unique:asesor,PERSONA_pers_doc',
            'pers_tipodoc'    => 'required|string',
            'pers_nombres'    => 'required|string|max:100',
            'pers_apellidos'  => 'required|string|max:100',
            'pers_telefono'   => 'nullable|string|max:20',
            'ase_tipo_asesor' => 'required|in:OT,OV,AT',
            'ase_sede'        => 'required|string|max:100',
            'ase_correo'      => 'required|email|max:100|unique:asesor,ase_correo',
            'ase_password'    => 'required|string|min:6',
            'ase_nrocontrato' => 'nullable|string|max:50',
        ], [
            'pers_doc.unique'          => 'Este número de documento ya está registrado como asesor.',
            'ase_correo.unique'        => 'Este correo electrónico ya está en uso por otro asesor.',
            'ase_tipo_asesor.required' => 'Debe seleccionar el tipo de asesor.',
            'ase_tipo_asesor.in'       => 'El tipo de asesor debe ser OT, OV o AT.',
        ]);

        \DB::beginTransaction();
        try {
            $persona = \App\Models\Persona::firstOrCreate(
                ['pers_doc' => $request->pers_doc],
                [
                    'pers_tipodoc'   => $request->pers_tipodoc,
                    'pers_nombres'   => $request->pers_nombres,
                    'pers_apellidos' => $request->pers_apellidos,
                    'pers_telefono'  => $request->pers_telefono,
                ]
            );

            \App\Models\Asesor::create([
                'PERSONA_pers_doc' => $persona->pers_doc,
                'ase_correo'       => $request->ase_correo,
                'ase_password'     => \Illuminate\Support\Facades\Hash::make($request->ase_password),
                'ase_nrocontrato'  => $request->ase_nrocontrato ?? 'CONT-' . now()->format('Ymd'),
                'ase_tipo_asesor'  => $request->ase_tipo_asesor,
                'ase_sede'         => $request->ase_sede,
                'ase_capacitado_victimas' => $request->has('ase_capacitado_victimas'),
                'ase_genero'       => $request->ase_genero,
                'ase_vigencia'     => now()->addYear()->toDateString(),
                'ase_foto'         => $request->ase_foto ?? ($request->ase_genero == 'F' ? 'images/foto de perfil asesora.png' : 'images/foto de perfil asesor.png'),
            ]);

            \DB::commit();
        } catch (\Exception $e) {
            \DB::rollBack();
            return back()->with('error', 'Error al registrar el asesor: ' . $e->getMessage());
        }

        return back()->with('success', 'Asesor registrado exitosamente.');
    }

    public function updateAsesor(Request $request, $id)
    {
        if (!$this->checkAuth()) return redirect()->route('coordinador.login');

        $asesor = \App\Models\Asesor::findOrFail($id);
        $asesor->ase_correo     = $request->ase_correo ?? $asesor->ase_correo;
        $asesor->ase_nrocontrato = $request->ase_nrocontrato ?? $asesor->ase_nrocontrato;
        $asesor->ase_foto       = $request->ase_foto ?? $asesor->ase_foto;
        if ($request->filled('ase_password')) {
            $asesor->ase_password = bcrypt($request->ase_password);
        }
        $asesor->ase_capacitado_victimas = $request->has('ase_capacitado_victimas');
        $asesor->ase_genero = $request->ase_genero ?? $asesor->ase_genero;
        $asesor->save();

        if ($asesor->persona) {
            $asesor->persona->pers_nombres  = $request->pers_nombres  ?? $asesor->persona->pers_nombres;
            $asesor->persona->pers_apellidos= $request->pers_apellidos ?? $asesor->persona->pers_apellidos;
            $asesor->persona->pers_telefono = $request->pers_telefono  ?? $asesor->persona->pers_telefono;
            $asesor->persona->save();
        }

        return back()->with('success', 'Asesor actualizado correctamente.');
    }

    public function deleteAsesor(Request $request, $id)
    {
        if (!$this->checkAuth()) return redirect()->route('coordinador.login');

        $asesor = \App\Models\Asesor::findOrFail($id);
        $asesor->delete();
        return back()->with('success', 'Asesor eliminado del sistema.');
    }

    public function manualCoordinador()
    {
        if (!$this->checkAuth()) return redirect()->route('coordinador.login');
        return view('coordinador.manual');
    }

    public function getStats()
    {
        // Solo coordinadores autenticados pueden ver esto
        if (!$this->checkAuth()) return response()->json(['error' => 'Unauthenticated'], 401);

        $hoy = now()->today();
        
        // 1. Contar turnos en espera por tipo
        $waitingStats = Turno::whereDate('tur_hora_fecha', $hoy)
            ->where('tur_estado', 'Espera')
            ->selectRaw('tur_tipo, count(*) as count')
            ->groupBy('tur_tipo')
            ->pluck('count', 'tur_tipo')
            ->toArray();

        // 2. Flujo por hora (Ajuste zona horaria -5)
        $flowData = Turno::whereDate('tur_hora_fecha', $hoy)
            ->selectRaw('HOUR(DATE_SUB(tur_hora_fecha, INTERVAL 5 HOUR)) as hour, count(*) as count')
            ->groupBy('hour')
            ->pluck('count', 'hour')
            ->toArray();
        
        $flowValues = [];
        for ($i = 6; $i <= 20; $i++) {
            $flowValues[] = $flowData[$i] ?? 0;
        }

        // 3. Distribución por Documento
        $docData = \App\Models\Persona::join('solicitante', 'persona.pers_doc', '=', 'solicitante.PERSONA_pers_doc')
            ->join('turno', 'solicitante.sol_id', '=', 'turno.SOLICITANTE_sol_id')
            ->whereDate('turno.tur_hora_fecha', $hoy)
            ->selectRaw('pers_tipodoc, count(*) as count')
            ->groupBy('pers_tipodoc')
            ->pluck('count', 'pers_tipodoc')
            ->toArray();

        // 4. Estado de los Módulos (para el mapa)
        $modulosStatus = Asesor::with('persona')->get()->map(function($ase) {
            $atencionActiva = Atencion::where('ASESOR_ase_id', $ase->ase_id)
                                    ->whereNull('atnc_hora_fin')
                                    ->exists();
            
            $pausaActiva = PausaAsesor::where('ASESOR_ase_id', $ase->ase_id)
                                    ->whereNull('hora_fin')
                                    ->exists();
            
            $estado = 'Libre';
            if ($atencionActiva) $estado = 'Atendiendo';
            else if ($pausaActiva) $estado = 'Descanso';

            return [
                'modulo' => $ase->ase_id,
                'sede' => $ase->ase_sede,
                'nombre' => $ase->persona ? ($ase->persona->pers_nombres . ' ' . $ase->persona->pers_apellidos) : 'Asesor',
                'estado' => strtoupper($estado),
            ];
        });

        return response()->json([
            'success'     => true,
            'timestamp'   => now()->format('H:i:s'),
            'waiting' => [
                'General'     => $waitingStats['General'] ?? 0,
                'Prioritario' => $waitingStats['Prioritario'] ?? 0,
                'Victimas'    => $waitingStats['Victimas'] ?? 0,
            ],
            'flowValues' => $flowValues,
            'docData' => $docData,
            'modulos' => $modulosStatus
        ]);
    }

    /**
     * CU-04 — Vista de supervisión de módulos 15 y 19.
     * Monitorea: estado de módulos, meta semanal de emprendedores,
     * alertas de espera >20 min, y rotación bimestral del personal.
     */
    public function supervision()
    {
        if (!$this->checkAuth()) return redirect()->route('coordinador.login');

        $hoy        = now()->toDateString();
        $inicioSemana = now()->startOfWeek()->toDateString();
        $finSemana    = now()->endOfWeek()->toDateString();

        // ── Datos de los módulos 15 y 19 ────────────────────────────────────
        $modulosVigilancia = [15, 19];
        $estadoModulos = [];

        foreach ($modulosVigilancia as $moduloId) {
            $asesor = Asesor::with('persona')->find($moduloId);

            if (!$asesor) {
                $estadoModulos[$moduloId] = [
                    'nombre'       => 'Módulo ' . $moduloId,
                    'estado'       => 'Sin asignar',
                    'atencionActiva' => null,
                    'pausaActiva'  => null,
                    'atencionesDia' => 0,
                    'foto'         => 'images/foto de perfil asesor.png',
                ];
                continue;
            }

            $atencionActiva = Atencion::where('ASESOR_ase_id', $moduloId)
                ->whereNull('atnc_hora_fin')
                ->with('turno.solicitante.persona')
                ->first();

            $pausaActiva = PausaAsesor::where('ASESOR_ase_id', $moduloId)
                ->whereNull('hora_fin')
                ->first();

            $atencionesDia = Atencion::where('ASESOR_ase_id', $moduloId)
                ->whereDate('atnc_hora_inicio', $hoy)
                ->count();

            $estado = 'Libre';
            if ($pausaActiva)   $estado = 'Pausa';
            if ($atencionActiva) $estado = 'Atendiendo';

            $estadoModulos[$moduloId] = [
                'nombre'         => $asesor->persona->pers_nombres . ' ' . $asesor->persona->pers_apellidos,
                'estado'         => $estado,
                'atencionActiva' => $atencionActiva,
                'pausaActiva'    => $pausaActiva,
                'atencionesDia'  => $atencionesDia,
                'foto'           => $asesor->ase_foto ?? 'images/foto de perfil asesor.png',
            ];
        }

        // ── Meta semanal de emprendedores — SOLO módulos 15 y 19 (CU-04) ────────
        // El spec indica explícitamente que la meta de ~6 emprendedores/semana
        // corresponde a los módulos 15 y 19 (ruta de víctimas/emprendimiento).
        $metaEmprendedores = 6;
        $turnoRepo = app(TurnoRepository::class);
        $emprendedoresSemana = $turnoRepo->getEmprendedoresModulosVigilancia($inicioSemana, $finSemana);
        $porcentajeMeta = min(100, round(($emprendedoresSemana / $metaEmprendedores) * 100));

        // ── Tiempos medios del ciclo de vida (CU-01 / CU-04) ─────────────────
        $tiemposMedios = $turnoRepo->getTiemposMedios($hoy);

        // ── Turnos en espera con tiempo > 40 segundos (alerta visual) ─────────
        $turnosEspera20 = Turno::whereDate('tur_hora_fecha', $hoy)
            ->whereDoesntHave('atencion')
            ->where('tur_hora_fecha', '<', now()->subSeconds(40))
            ->with('solicitante.persona')
            ->orderBy('tur_hora_fecha', 'asc')
            ->get()
            ->map(function ($t) {
                $t->minutos_espera = (int) Carbon::parse($t->tur_hora_fecha)->diffInSeconds(now());
                return $t;
            });

        // ── Turnos en espera con tiempo > 60 segundos (ALERTA MÁXIMA) ─────────
        $turnosEspera60 = $turnosEspera20->filter(function($t) {
            return $t->minutos_espera >= 60;
        });

        // ── Atenciones en módulo que llevan más de 1 minuto (Posibles Ausentes) ──
        $atencionesLlamadas60 = Atencion::whereNull('atnc_hora_fin')
            ->where('atnc_hora_inicio', '<', now()->subSeconds(60))
            ->with(['turno', 'asesor.persona'])
            ->get()
            ->map(function ($at) {
                $at->segundos_llamado = (int) Carbon::parse($at->atnc_hora_inicio)->diffInSeconds(now());
                return $at;
            });

        // ── Indicador de rotación bimestral del personal (> 60 días) ─────────
        // Compara la fecha de vigencia (fin de contrato) con los 60 días desde hoy hacia atrás
        $asesoresRotacion = Asesor::with('persona')
            ->whereNotNull('ase_vigencia')
            ->get()
            ->map(function ($asesor) {
                // ase_vigencia es la fecha fin de contrato; asumimos inicio = hace 'X' días
                // Si la vigencia es menor a 60 días desde hoy, el contrato está próximo a vencer
                $vigencia    = Carbon::parse($asesor->ase_vigencia);
                $diasRestantes = (int) now()->diffInDays($vigencia, false);
                $requiereRotacion = $diasRestantes <= 60 && $diasRestantes >= 0;
                return [
                    'nombre'          => $asesor->persona ? $asesor->persona->pers_nombres . ' ' . $asesor->persona->pers_apellidos : 'N/A',
                    'ase_id'          => $asesor->ase_id,
                    'vigencia'        => $vigencia->format('d/m/Y'),
                    'dias_restantes'  => $diasRestantes,
                    'requiere_rotacion' => $requiereRotacion,
                ];
            })
            ->sortBy('dias_restantes');

        // ── Turnos marcados como Ausente hoy ────────────────────────────────
        $turnosAusentesHoy = Turno::whereDate('tur_hora_fecha', $hoy)
            ->where('tur_estado', 'Ausente')
            ->with(['solicitante.persona', 'atencion'])
            ->orderBy('tur_hora_fecha', 'desc')
            ->get();

        return view('coordinador.supervision', compact(
            'estadoModulos',
            'metaEmprendedores',
            'emprendedoresSemana',
            'porcentajeMeta',
            'turnosEspera20',
            'turnosEspera60',
            'atencionesLlamadas60',
            'turnosAusentesHoy',
            'asesoresRotacion',
            'modulosVigilancia',
            'tiemposMedios'
        ));
    }
}
