
<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'
// import { ArrowRightCircleIcon } from '@heroicons/vue/24/outline'
const navOpen = ref(false)
</script>


<template>

    <div class="main px-2 sm:px-5 bg-[#DCC5B2] pt-3 sm:pt-5 flex flex-col items-center min-h-screen">
        <div class="navbar h-[60px] sm:h-[80px] bg-[#FAF7F3] w-full sm:w-4/5 rounded-none sm:rounded-3xl flex items-center px-4 sm:px-10 mb-3 sm:mb-5 sticky top-3">
            <img class="logo w-[40px] h-[40px] sm:w-[50px] sm:h-[50px]" src="@assets/images/logo1.png" alt="Logo-pempek">
            <!-- Hamburger button for mobile -->
            <button @click="navOpen = !navOpen" class="ml-auto sm:hidden p-2 focus:outline-none cursor-pointer" aria-label="Toggle navigation">
                <svg v-if="!navOpen" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-7 h-7 text-[#4A2C24]">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5M3.75 17.25h16.5" />
                </svg>
                <svg v-else xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-7 h-7 text-[#4A2C24]">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
            <!-- Desktop menu -->
            <div class="menu hidden sm:grid grid-cols-3 gap-5 w-auto ml-5">
                <a href="#" class="menu-item text-base">Home</a>
                <a href="#" class="menu-item text-base">About</a>
                <a href="#" class="menu-item text-base">Contact</a>
            </div>
            <!-- Mobile dropdown menu with smooth transition and backdrop -->
            <transition
                enter-active-class="transition duration-300 ease-out"
                leave-active-class="transition duration-200 ease-in"
                enter-from-class="opacity-0 -translate-y-2"
                enter-to-class="opacity-100 translate-y-0"
                leave-from-class="opacity-100 translate-y-0"
                leave-to-class="opacity-0 -translate-y-2"
            >
                <div v-if="navOpen" class="fixed inset-0 z-30 flex sm:hidden">
                    <!-- Backdrop -->
                    <div class="absolute inset-0 bg-black-1/100 backdrop-blur-sm" @click.self="navOpen = false"></div>
                    <!-- Dropdown -->
                    <div class="absolute top-[60px] left-0 w-full bg-[#FAF7F3] shadow-lg rounded-b-xl flex flex-col items-center">
                        <a href="#" class="menu-item text-base py-3 w-full text-center border-b border-[#E5E5E5]">Home</a>
                        <a href="#" class="menu-item text-base py-3 w-full text-center border-b border-[#E5E5E5]">About</a>
                        <a href="#" class="menu-item text-base py-3 w-full text-center">Contact</a>
                    </div>
                </div>
            </transition>
        </div>

        <div class="content bg-[#FAF7F3] w-full sm:w-4/5 rounded-none sm:rounded-3xl flex flex-col items-center px-2 sm:px-10 pt-5 sm:pt-[40px]">
            <h1 class="text-2xl sm:text-5xl mb-2 sm:mb-3 text-[#4A2C24] text-center">Cita Rasa Pempek, Sepenuh Hati</h1>
            <h3 class="mb-3 sm:mb-6 text-[#5C3A2E] text-sm sm:text-lg text-center">Nikmati cita rasa pempek yang autentik dan lezat, dibuat dengan sepenuh hati.</h3>
            <div class="w-full sm:w-3/5 text-center font-extralight text-[#866A56] mb-2 sm:mb-0">
                <p>Selamat datang di katalog pempek keluarga kami!
Kami bangga menyajikan berbagai pilihan pempek berkualitas tinggi — dibuat dengan ikan segar, resep asli Palembang, dan cinta dari dapur keluarga kami.</p>
            </div>

            <div class="content-list grid grid-cols-1 sm:grid-cols-2 gap-4 sm:gap-5 mt-6 sm:mt-10 w-full">
                <div class="content-item bg-white rounded-lg p-3 sm:p-5 shadow-lg">
                    <div class="flex items-center justify-between mb-2">
                        <h4 class="text-2xl sm:text-4xl text-[#4A2C24] font-semibold">Kapal Selam</h4>
                        <!-- <ArrowRightCircleIcon class="w-8 h-8 sm:w-12 sm:h-12 text-[#4A2C24] cursor-pointer" /> -->
                    </div>
                    <p class="text-xs sm:text-sm text-gray-700 mb-4 sm:mb-6">Pempek klasik berisi telur ayam utuh yang dibalut adonan ikan tenggiri kenyal, disajikan dengan kuah cuko khas Palembang yang gurih dan segar.</p>
                    <img class="aspect-square rounded-md w-full object-cover max-h-30 sm:max-h-none" src="@assets/images/pempek_lenjer.png" alt="pempek kapal selam enak">
                </div>
                <div class="content-item bg-white rounded-lg p-3 sm:p-5 shadow-lg">
                    <div class="flex items-center justify-between mb-2">
                        <h4 class="text-2xl sm:text-4xl text-[#4A2C24] font-semibold">Lenjer</h4>
                        <!-- <ArrowRightCircleIcon class="w-8 h-8 sm:w-12 sm:h-12 text-[#4A2C24] cursor-pointer" /> -->
                    </div>
                    <p class="text-xs sm:text-sm text-gray-700 mb-4 sm:mb-6">Pempek berbentuk panjang dengan tekstur lembut dan rasa ikan tenggiri yang khas, cocok dinikmati bersama cuko hangat atau digoreng kembali.</p>
                    <img class="aspect-square rounded-md w-full object-cover max-h-30 sm:max-h-none" src="@assets/images/pempek_lenjer.png" alt="pempek lenjer enak">
                </div>
                <div class="content-item bg-white rounded-lg p-3 sm:p-5 shadow-lg">
                    <div class="flex items-center justify-between mb-2">
                        <h4 class="text-2xl sm:text-4xl text-[#4A2C24] font-semibold">Adaan</h4>
                        <!-- <ArrowRightCircleIcon class="w-8 h-8 sm:w-12 sm:h-12 text-[#4A2C24] cursor-pointer" /> -->
                    </div>
                    <p class="text-xs sm:text-sm text-gray-700 mb-4 sm:mb-6">Pempek goreng berbentuk bulat dengan aroma daun bawang dan rempah, renyah di luar dan lembut di dalam, cocok jadi camilan atau lauk makan siang.</p>
                    <img class="aspect-square rounded-md w-full object-cover max-h-30 sm:max-h-none" src="@assets/images/pempek_lenjer.png" alt="pempek adhaan enak">
                </div>

            </div>
        </div>
    </div>
</template>