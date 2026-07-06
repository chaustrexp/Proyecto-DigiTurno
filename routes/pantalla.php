<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Pantalla\PantallaController;
use App\Http\Controllers\Api\ApiController;

// Pantalla
Route::get('/pantalla', [PantallaController::class, 'index'])->name('pantalla.index');
Route::get('/api/pantalla/data', [ApiController::class, 'getPantallaData'])->name('pantalla.api.data');
