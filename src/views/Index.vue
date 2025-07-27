<script setup lang="ts">
import { ArrowRightCircleIcon } from '@heroicons/vue/24/outline'
</script>


<template>
    <div class="main px-5 bg-[#DCC5B2] pt-5 flex flex-col items-center">
        <div class="navbar h-[80px] bg-[#FAF7F3] w-4/5 rounded-3xl flex items-center  px-10 mb-5">
            <img class="w-100 h-auto logo mr-10 w-[50px] h-[50px]" src="@assets/images/logo1.png" alt="Logo-pempek">
            <div class="menu grid grid-cols-3 gap-5">
                <a href="#" class="menu-item">Home</a>
                <a href="#" class="menu-item">About</a>
                <a href="#" class="menu-item">Contact</a>
            </div>
        </div>

        <div class="content bg-[#FAF7F3] w-4/5 rounded-3xl flex flex-col items-center  px-10 pt-[40px]">
            <h1 class="text-5xl mb-3 text-[#4A2C24]">Cita Rasa Pempek, Sepenuh Hati</h1>
            <h3 class="mb-6 text-[#5C3A2E]">Nikmati cita rasa pempek yang autentik dan lezat, dibuat dengan sepenuh hati.</h3>
            <div class="w-3/5 text-center font-extralight text-[#866A56]">
                <p>Selamat datang di katalog pempek keluarga kami!
Kami bangga menyajikan berbagai pilihan pempek berkualitas tinggi — dibuat dengan ikan segar, resep asli Palembang, dan cinta dari dapur keluarga kami.</p>
            </div>

            <div class="content-list grid grid-cols-2 gap-5 mt-10">
                <div class="content-item bg-white rounded-lg p-5 shadow-lg">
                    <div class="flex items-center justify-between mb-2">
                        <h4 class="text-4xl text-[#4A2C24] font-semibold">Kapal Selam</h4>
                        <ArrowRightCircleIcon class="w-12 h-12 text-[#4A2C24] cursor-pointer" />
                    </div>
                    <p class="text-sm text-gray-700 mb-6">Pempek klasik berisi telur ayam utuh yang dibalut adonan ikan tenggiri kenyal, disajikan dengan kuah cuko khas Palembang yang gurih dan segar.</p>
                    <img class="aspect-1/1 rounded-md" src="@assets/images/pempek_lenjer.png" alt="pempek kapal selam enak">
                </div>
                <div class="content-item bg-white rounded-lg p-5 shadow-lg">
                    <div class="flex items-center justify-between mb-2">
                        <h4 class="text-4xl text-[#4A2C24] font-semibold">Lenjer</h4>
                        <ArrowRightCircleIcon class="w-12 h-12 text-[#4A2C24] cursor-pointer" />
                    </div>
                    <p class="text-sm text-gray-700 mb-6">Pempek berbentuk panjang dengan tekstur lembut dan rasa ikan tenggiri yang khas, cocok dinikmati bersama cuko hangat atau digoreng kembali.</p>
                    <img class="aspect-1/1 rounded-md" src="@assets/images/pempek_lenjer.png" alt="pempek lenjer enak">
                </div>
                <div class="content-item bg-white rounded-lg p-5 shadow-lg">
                    <div class="flex items-center justify-between mb-2">
                        <h4 class="text-4xl text-[#4A2C24] font-semibold">Adaan</h4>
                        <ArrowRightCircleIcon class="w-12 h-12 text-[#4A2C24] cursor-pointer" />
                    </div>
                    <p class="text-sm text-gray-700 mb-6">Pempek goreng berbentuk bulat dengan aroma daun bawang dan rempah, renyah di luar dan lembut di dalam, cocok jadi camilan atau lauk makan siang.</p>
                    <img class="aspect-1/1 rounded-md" src="@assets/images/pempek_lenjer.png" alt="pempek adhaan enak">
                </div>

            </div>
        </div>
    </div>
</template>