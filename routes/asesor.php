<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Asesor\AsesorController;

// Asesor Auth
Route::get('/asesor/login', [AsesorController::class, 'showLogin'])->name('asesor.login');
Route::post('/asesor/login', [AsesorController::class, 'login']);
Route::post('/asesor/logout', [AsesorController::class, 'logout'])->name('asesor.logout');
Route::get('/asesor/register', [AsesorController::class, 'showRegister'])->name('asesor.register');
Route::post('/asesor/register', [AsesorController::class, 'register'])->name('asesor.register.post');
Route::get('/asesor/recuperar-clave', function() {
    return view('asesor.recuperar_clave');
})->name('asesor.recuperar');

// Asesor
Route::get('/asesor', [AsesorController::class, 'index'])->name('asesor.index');
Route::get('/asesor/actividad', [AsesorController::class, 'actividad'])->name('asesor.actividad');
Route::get('/asesor/tramites', [AsesorController::class, 'tramites'])->name('asesor.tramites');
Route::get('/asesor/reportes', [AsesorController::class, 'reportes'])->name('asesor.reportes');
Route::get('/asesor/configuracion', [AsesorController::class, 'configuracion'])->name('asesor.configuracion');
Route::get('/manual/asesor', [AsesorController::class, 'manualAsesor'])->name('manual.asesor');

// Acciones del Asesor
Route::post('/asesor/llamar', [AsesorController::class, 'llamar'])->name('asesor.llamar');
Route::post('/asesor/finalizar/{atnc_id}', [AsesorController::class, 'finalizar'])->name('asesor.finalizar');
Route::post('/asesor/ausente/{atnc_id}', [AsesorController::class, 'ausente'])->name('asesor.ausente');
Route::post('/asesor/rellamar/{atnc_id}', [AsesorController::class, 'rellamar'])->name('asesor.rellamar');
Route::post('/asesor/iniciar/{atnc_id}', [AsesorController::class, 'iniciar'])->name('asesor.iniciar');
Route::post('/asesor/persona/update/{pers_doc}', [AsesorController::class, 'updatePersona'])->name('asesor.persona.update');

// CU-03: Receso del Asesor
Route::post('/asesor/receso/iniciar', [AsesorController::class, 'registrarReceso'])->name('asesor.receso.iniciar');
Route::post('/asesor/receso/finalizar', [AsesorController::class, 'finalizarReceso'])->name('asesor.receso.finalizar');
