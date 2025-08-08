<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'
import pempek from '@/assets/images/pempek_lenjer.png'

const slides = [
  { img: pempek, title: 'Explore & Customize', text: 'Browse a wide variety of pempek, lenjer, and more. Customize your order perfectly.' },
  { img: pempek, title: 'Fresh & Tasty', text: 'Our pempek is made fresh daily with the finest ingredients.' },
  { img: pempek, title: 'Fast Delivery', text: 'Get your favorite pempek delivered to your doorstep in minutes.' }
]

const currentIndex = ref(0)
let intervalId: number

const goToNext = () => {
  console.log('Get started clicked');
}

const nextSlide = () => {
  currentIndex.value = (currentIndex.value + 1) % slides.length
}

onMounted(() => {
  intervalId = setInterval(nextSlide, 3000)
})

onBeforeUnmount(() => {
  clearInterval(intervalId)
})
</script>

<template>
  <div class="h-screen flex flex-col overflow-hidden bg-white">
    <!-- Floating Navbar -->
    <div class="absolute top-0 left-0 right-0 z-20 flex items-center justify-between px-4 py-3 bg-white/30 backdrop-blur-sm">
      <button class="p-2 rounded-full bg-white/50 hover:bg-white/70">
        <!-- Back icon -->
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-[#4b2f22]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
        </svg>
      </button>
      <h1 class="text-lg font-semibold text-[#4b2f22]">Pempek App</h1>
      <button class="p-2 rounded-full bg-white/50 hover:bg-white/70">
        <!-- Menu icon -->
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-[#4b2f22]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
        </svg>
      </button>
    </div>

    <!-- Image Slider -->
    <div class="relative h-[70%] overflow-hidden">
      <div
        class="flex transition-all duration-700 ease-in-out"
        :style="{ transform: `translateX(-${currentIndex * 100}%)` }"
      >
        <div v-for="(slide, i) in slides" :key="i" class="w-full flex-none h-[70%]">
          <img :src="slide.img" alt="Slide Image" class="w-full h-full object-cover object-center" />
        </div>
      </div>

      <!-- Gradient overlay -->
      <div class="absolute bottom-0 w-full h-24 bg-gradient-to-b from-transparent to-[#f4e6d0]/95 backdrop-blur-sm"></div>
    </div>

    <!-- Content -->
    <div class="flex-1 flex flex-col items-center justify-between pb-8 bg-gradient-to-b from-[#f4e6d0] to-white">
      <!-- Pagination dots -->
      <div class="flex space-x-2 mt-4">
        <span
          v-for="(slide, i) in slides"
          :key="'dot' + i"
          class="w-2 h-2 rounded-full transition-colors duration-300"
          :class="currentIndex === i ? 'bg-[#4b2f22]' : 'bg-[#d9c4a0]'"
        ></span>
      </div>

      <!-- Text -->
      <div class="text-center px-6">
        <h1 class="text-3xl font-bold mb-2 text-[#4b2f22]">
          {{ slides[currentIndex].title }}
        </h1>
        <p class="text-[#5c4639] text-sm">
          {{ slides[currentIndex].text }}
        </p>
      </div>

      <!-- Button -->
      <div class="w-full px-6">
        <button
          @click="goToNext"
          class="w-full py-4 bg-[#4b2f22] text-white rounded-full text-lg font-semibold hover:bg-[#3a2419] transition-colors"
        >
          Get started
        </button>
      </div>
    </div>
  </div>
</template>
