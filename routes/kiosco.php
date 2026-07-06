<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Kiosco\TurnoController;
use App\Http\Controllers\Api\ApiController;

// Kiosco
Route::get('/', [TurnoController::class, 'index'])->name('kiosco.index');
Route::get('/kiosco', [TurnoController::class, 'index']);
Route::get('/solicitar', [TurnoController::class, 'index']);
Route::post('/turno/solicitar', [TurnoController::class, 'store'])
    ->name('turnos.store')
    ->middleware('throttle:kiosk');
Route::get('/api/turno/consultar/{documento}', [ApiController::class, 'consultarTurno'])->name('api.turno.consultar');
Route::get('/seguimiento/{documento}', [ApiController::class, 'seguimientoTurno'])->name('turno.seguimiento');
