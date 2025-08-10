<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'
import pempekMix from '@/assets/images/frozen/frozen_pempek_mix.jpeg'
import pempekAdaan from '@/assets/images/frozen/frozen_pempek_adaan.jpeg'
import pempekKulit from '@/assets/images/frozen/frozen_pempek_kulit.jpeg'
import pempekKapalSelam from '@/assets/images/frozen/frozen_pempek_kapal_selam.jpeg'    
import pempekLenjer from '@/assets/images/frozen/frozen_pempek_lenjer.jpeg'

const slides = [
  { img: pempekLenjer, title: 'Pempek Lenjer', text: 'Pempek berbentuk panjang dengan tekstur lembut dan rasa ikan tenggiri yang khas, cocok dinikmati bersama cuko hangat atau digoreng kembali.', price: 'Rp 20.000,00' },
  { img: pempekAdaan, title: 'Pempek Adaan', text: 'Pempek goreng berbentuk bulat dengan aroma daun bawang dan rempah, renyah di luar dan lembut di dalam, cocok jadi camilan atau lauk makan siang.', price: 'Rp 20.000,00' },
  { img: pempekKulit, title: 'Pempek Kulit', text: 'Pempek khas dengan bahan utama kulit ikan tenggiri, digoreng hingga renyah dan gurih, menghadirkan rasa autentik yang kaya akan umami.', price: 'Rp 18.000,00' },
  { img: pempekKapalSelam, title: 'Pempek Kapal Selam', text: 'Pempek klasik berisi telur ayam yang dibalut adonan ikan tenggiri kenyal, disajikan dengan kuah cuko khas yang gurih dan segar.', price: 'Rp 20.000,00' },
  { img: pempekMix, title: 'Pempek Mix', text: 'Paket isi berbagai pempek favorit, praktis & hemat!', price: 'Rp 20.000,00' }
]

const currentIndex = ref(0)
let intervalId: number

// Touch tracking
let startX = 0
let endX = 0

const goToNext = () => {
  console.log('Get started clicked')
}

const nextSlide = () => {
  currentIndex.value = (currentIndex.value + 1) % slides.length
}

const prevSlide = () => {
  currentIndex.value = (currentIndex.value - 1 + slides.length) % slides.length
}

// Handle touch start
const handleTouchStart = (e: TouchEvent) => {
  startX = e.touches[0].clientX
}

// Handle touch move
const handleTouchMove = (e: TouchEvent) => {
  endX = e.touches[0].clientX
}

// Handle touch end
const handleTouchEnd = () => {
  const deltaX = endX - startX
  if (Math.abs(deltaX) > 50) {
    if (deltaX > 0) {
      prevSlide()
    } else {
      nextSlide()
    }
  }
}

const openLink = () => {
const params = new URLSearchParams({
    text: `Halo, saya ingin memesan ${slides[currentIndex.value].title}`
})
window.open(`https://wa.me/6285779983483?${params.toString()}`, '_blank')
}

onMounted(() => {
//   intervalId = setInterval(nextSlide, 3000)
})

onBeforeUnmount(() => {
//   clearInterval(intervalId)
})
</script>

<template>
  <div class="h-screen flex flex-col overflow-hidden bg-white">
    <!-- Floating Navbar -->
    <div class="absolute top-0 left-0 right-0 z-20 flex items-center justify-center px-4 pb-3 pt-5 bg-[#f9f1e6] backdrop-blur-sm w-full h-[60px]">
      <div>
        <img src="@/assets/images/logohd-removebg-preview.png" alt="Logo" class="h-[60px]">
      </div>
    </div>

    <!-- Image Slider -->
    <div 
      class="relative h-[70%] overflow-hidden"
      @touchstart="handleTouchStart"
      @touchmove="handleTouchMove"
      @touchend="handleTouchEnd"
    >
      <div
        class="flex transition-all duration-700 ease-in-out"
        :style="{ transform: `translateX(-${currentIndex * 100}%)` }"
      >
        <div v-for="(slide, i) in slides" :key="i" class="w-full flex-none h-[70%] relative overflow-hidden">
            <img :src="slide.img" alt="Slide Image" class="w-full h-full relative" style="left: 0; top: -80%;"  />
        </div>
      </div>

      <!-- Gradient overlay -->
      <div class="absolute bottom-0 w-full h-10 bg-gradient-to-b from-transparent to-[#f4e6d0]/95 backdrop-blur-sm"></div>
    </div>

    <!-- Content -->
    <div class="flex-1 flex flex-col items-center justify-between pb-8 bg-gradient-to-b from-[#f4e6d0] to-white pt-3">
      <!-- Pagination dots -->
      <div class="flex space-x-2 mb-4">
        <span
          v-for="(slide, i) in slides"
          :key="'dot' + i"
          class="w-2 h-2 rounded-full transition-colors duration-300"
          :class="currentIndex === i ? 'bg-[#4b2f22]' : 'bg-[#d9c4a0]'"
        ></span>
      </div>

      <!-- Text -->
      <div class="text-center px-6">
        <h1 class="text-3xl font-bold mb-2 text-[#af603b]">
          {{ slides[currentIndex].title }}
        </h1>
        <p class="text-[#5c4639]/70 text-sm">
          {{ slides[currentIndex].text }}
        </p>
        <p class="text-[#5c4639] text-2xl font-semibold mt-2 mb-5">
            {{ slides[currentIndex].price }}
        </p>
      </div>

      <!-- Button -->
      <div class="w-full px-6">
        <button
          @click="openLink"
          class="w-full py-4 bg-[#af603b] text-white rounded-full text-lg font-semibold hover:bg-[#3a2419] transition-colors"
        >
          Order Now
        </button>
      </div>
    </div>
  </div>
</template>
