<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SENA APE - Mi Turno</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&family=Poppins:wght@800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = { theme: { extend: { colors: { sena: { 500: '#10069F', orange: '#FF671F' } } } } }
    </script>
    <style>
        body { background-color: #f8fafc; font-family: 'Inter', sans-serif; }
        .ticket-shadow { box-shadow: 0 20px 50px -12px rgba(16, 6, 159, 0.15); }
    </style>
</head>
<body class="min-h-screen flex flex-col items-center p-6">
    <div class="w-full max-w-sm space-y-8">
        <!-- Header Logo -->
        <div class="flex justify-center mb-10">
            <img src="{{ asset('images/LOGO APE_color.png') }}" class="h-16 w-auto" alt="Logo SENA APE">
        </div>

        <!-- Main Card -->
        <div class="bg-white rounded-[3rem] p-8 ticket-shadow border border-slate-100 relative overflow-hidden">
            <!-- Decorative circle -->
            <div class="absolute -top-10 -right-10 w-32 h-32 bg-sena-500/5 rounded-full blur-2xl"></div>
            
            <div class="text-center space-y-2 mb-8">
                <p class="text-[10px] font-black text-slate-400 uppercase tracking-[0.2em]">Hola, {{ $ciudadano }}</p>
                <h1 class="text-2xl font-black text-slate-900 leading-tight">Estado de tu Turno</h1>
            </div>

            <!-- Turn Number -->
            <div class="bg-slate-50 border-2 border-slate-100 rounded-[2.5rem] py-8 text-center relative mb-8">
                <p class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1">TU TURNO ES EL</p>
                <div class="text-6xl font-poppins font-black text-sena-500 tracking-tighter">{{ $turno->tur_numero }}</div>
                <div class="absolute -bottom-3 left-1/2 -translate-x-1/2 bg-sena-orange text-white text-[9px] font-black px-4 py-1.5 rounded-full shadow-lg uppercase tracking-widest">
                    {{ $turno->tur_estado }}
                </div>
            </div>

            <!-- Wait Status -->
            <div class="space-y-4">
                <div class="flex items-center justify-between p-4 bg-blue-50 rounded-2xl border border-blue-100">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-white rounded-xl flex items-center justify-center text-blue-500 shadow-sm">
                            <i class="fa-solid fa-users"></i>
                        </div>
                        <div>
                            <p class="text-[9px] font-black text-blue-400 uppercase tracking-widest leading-none">En espera</p>
                            <p class="text-sm font-black text-blue-700">{{ $espera }} personas delante</p>
                        </div>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-3">
                    <div class="p-4 bg-slate-50 rounded-2xl border border-slate-100">
                        <p class="text-[8px] font-black text-slate-400 uppercase tracking-widest">Servicio</p>
                        <p class="text-xs font-bold text-slate-700">{{ $turno->tur_servicio }}</p>
                    </div>
                    <div class="p-4 bg-slate-50 rounded-2xl border border-slate-100">
                        <p class="text-[8px] font-black text-slate-400 uppercase tracking-widest">Perfil</p>
                        <p class="text-xs font-bold text-slate-700">{{ $turno->tur_perfil }}</p>
                    </div>
                </div>
            </div>

            <!-- Footer Text -->
            <div class="mt-8 text-center">
                <p class="text-[10px] font-medium text-slate-400 leading-relaxed italic">
                    Te llamaremos por los altavoces y en las pantallas de la sala. Por favor, permanece atento.
                </p>
            </div>
        </div>

        <!-- Call to Action -->
        <div class="text-center">
            <button onclick="window.location.reload()" class="text-xs font-black text-sena-500 uppercase tracking-widest flex items-center justify-center gap-2 mx-auto hover:scale-105 transition-transform">
                <i class="fa-solid fa-rotate"></i> Actualizar Estado
            </button>
        </div>

        <!-- Institutional Footer -->
        <div class="pt-10 flex flex-col items-center gap-4 border-t border-slate-200">
            <p class="text-[10px] font-black text-slate-400 uppercase tracking-[0.3em]">SENA • APE Digital</p>
            <div class="flex gap-4">
                <i class="fa-brands fa-facebook text-slate-300"></i>
                <i class="fa-brands fa-twitter text-slate-300"></i>
                <i class="fa-brands fa-instagram text-slate-300"></i>
            </div>
        </div>
    </div>
</body>
</html>
