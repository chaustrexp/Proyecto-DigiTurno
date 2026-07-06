<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Coordinador\CoordinadorController;

// Coordinador Auth
Route::get('/coordinador/login', [CoordinadorController::class, 'showLogin'])->name('coordinador.login');
Route::post('/coordinador/login', [CoordinadorController::class, 'login']);
Route::post('/coordinador/logout', [CoordinadorController::class, 'logout'])->name('coordinador.logout');
Route::get('/coordinador/register', [CoordinadorController::class, 'showRegister'])->name('coordinador.register');
Route::post('/coordinador/register', [CoordinadorController::class, 'register'])->name('coordinador.register.post');

// Coordinador
Route::get('/coordinador', [CoordinadorController::class, 'index'])->name('coordinador.index');
Route::get('/api/coordinador/stats', [CoordinadorController::class, 'getStats'])->name('coordinador.api.stats');
Route::get('/dashboard-coordinador', [CoordinadorController::class, 'dashboard'])->name('coordinador.dashboard');
Route::get('/coordinador/export', [CoordinadorController::class, 'export'])->name('coordinador.export');
Route::get('/coordinador/reportes', [CoordinadorController::class, 'reportes'])->name('coordinador.reportes');
Route::get('/coordinador/modulos', [CoordinadorController::class, 'modulos'])->name('coordinador.modulos');
Route::post('/coordinador/modulos/store', [CoordinadorController::class, 'storeAsesor'])->name('coordinador.asesores.store');
Route::post('/coordinador/modulos/update/{id}', [CoordinadorController::class, 'updateAsesor'])->name('coordinador.asesores.update');
Route::post('/coordinador/modulos/delete/{id}', [CoordinadorController::class, 'deleteAsesor'])->name('coordinador.asesores.delete');
Route::get('/coordinador/configuracion', [CoordinadorController::class, 'configuracion'])->name('coordinador.configuracion');
Route::get('/manual/coordinador', [CoordinadorController::class, 'manualCoordinador'])->name('manual.coordinador');

// CU-04: Supervisión del Coordinador (módulos 15 y 19)
Route::get('/coordinador/supervision', [CoordinadorController::class, 'supervision'])->name('coordinador.supervision');
