<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'

// Add CSS in the style block instead of JavaScript
import pempekMix from '@/assets/images/frozen/frozen_pempek_mix.jpeg'
import pempekAdaan from '@/assets/images/frozen/frozen_pempek_adaan.jpeg'
import pempekKulit from '@/assets/images/frozen/frozen_pempek_kulit.jpeg'
import pempekKapalSelam from '@/assets/images/frozen/frozen_pempek_kapal_selam.jpeg'    
import pempekLenjer from '@/assets/images/frozen/frozen_pempek_lenjer.jpeg'

import pempekGorengMix from '@/assets/images/goreng/pempek_mix_goreng.jpeg'
import pempekGorengAdaan from '@/assets/images/goreng/pempek_adaan_goreng.jpeg'
import pempekGorengKulit from '@/assets/images/goreng/pempek_kulit_goreng.jpeg'
import pempekGorengKapalSelam from '@/assets/images/goreng/pempek_kapal_selam_goreng.jpeg'    
import pempekGorengLenjer from '@/assets/images/goreng/pempek_lenjer_goreng.jpeg'

const frozenSlides = [
  { 
    img: pempekLenjer, 
    title: 'Pempek Frozen Lenjer', 
    text: 'Pempek berbentuk panjang dengan tekstur lembut dan rasa ikan tenggiri yang khas, cocok dinikmati bersama cuko hangat atau digoreng kembali. Dibuat dengan resep autentik Palembang.',
    price: 'Rp 20.000,00',
    altText: 'Pempek Lenjer Frozen Palembang - Makmantu'
  },
  { img: pempekAdaan, title: 'Pempek Frozen Adaan', text: 'Pempek goreng berbentuk bulat dengan aroma daun bawang dan rempah, renyah di luar dan lembut di dalam, cocok jadi camilan atau lauk makan siang.', price: 'Rp 20.000,00' },
  { img: pempekKulit, title: 'Pempek Frozen Kulit', text: 'Pempek khas dengan bahan utama kulit ikan tenggiri, digoreng hingga renyah dan gurih, menghadirkan rasa autentik yang kaya akan umami.', price: 'Rp 18.000,00' },
  { img: pempekKapalSelam, title: 'Pempek Frozen Kapal Selam', text: 'Pempek klasik berisi telur ayam yang dibalut adonan ikan tenggiri kenyal, disajikan dengan kuah cuko khas yang gurih dan segar.', price: 'Rp 20.000,00' },
  { img: pempekMix, title: 'Pempek Frozen Mix', text: 'Paket isi berbagai pempek favorit, praktis & hemat!', price: 'Rp 20.000,00' }
]

const freshSlides = [
  { img: pempekGorengLenjer, title: 'Pempek Goreng Lenjer', text: 'Pempek lenjer segar siap santap dengan tekstur lembut dan rasa ikan tenggiri yang khas, disajikan dengan cuko hangat.', price: 'Rp 20.000,00' },
  { img: pempekGorengAdaan, title: 'Pempek Goreng Adaan', text: 'Pempek adaan segar yang baru digoreng, dengan aroma daun bawang dan rempah yang menggugah selera.', price: 'Rp 20.000,00' },
  { img: pempekGorengKulit, title: 'Pempek Goreng Kulit', text: 'Pempek kulit segar dengan tekstur renyah dan gurih, disajikan hangat dengan cuko spesial.', price: 'Rp 18.000,00' },
  { img: pempekGorengKapalSelam, title: 'Pempek Goreng Kapal Selam', text: 'Pempek kapal selam segar dengan isian telur yang masih hangat, disajikan dengan cuko spesial.', price: 'Rp 20.000,00' },
  { img: pempekGorengMix, title: 'Pempek Goreng Mix', text: 'Paket komplit pempek segar siap santap!', price: 'Rp 20.000,00' }
]

const frozenIndex = ref(0)
const freshIndex = ref(0)
let intervalId: number

// Touch tracking
let startX = 0
let endX = 0

const nextSlide = (isFrozen: boolean = true) => {
  if (isFrozen) {
    frozenIndex.value = (frozenIndex.value + 1) % frozenSlides.length
  } else {
    freshIndex.value = (freshIndex.value + 1) % freshSlides.length
  }
}

const prevSlide = (isFrozen: boolean = true) => {
  if (isFrozen) {
    frozenIndex.value = (frozenIndex.value - 1 + frozenSlides.length) % frozenSlides.length
  } else {
    freshIndex.value = (freshIndex.value - 1 + freshSlides.length) % freshSlides.length
  }
}

// Handle touch start
const handleTouchStart = (e: TouchEvent) => {
  startX = e.touches[0].clientX
}

// Handle touch move
const handleTouchMove = (e: TouchEvent) => {
  endX = e.touches[0].clientX
}

// Handle touch end for both sections
const handleTouchEndFrozen = () => {
  const deltaX = endX - startX
  if (Math.abs(deltaX) > 50) {
    if (deltaX > 0) {
      prevSlide(true)
    } else {
      nextSlide(true)
    }
  }
}

const handleTouchEndFresh = () => {
  const deltaX = endX - startX
  if (Math.abs(deltaX) > 50) {
    if (deltaX > 0) {
      prevSlide(false)
    } else {
      nextSlide(false)
    }
  }
}

const openFrozenLink = () => {
  const currentSlide = frozenSlides[frozenIndex.value]
  const params = new URLSearchParams({
    text: `Halo, saya ingin memesan ${currentSlide.title}`
  })
  window.open(`https://wa.me/6285779983483?${params.toString()}`, '_blank')
}

const openFreshLink = () => {
  const currentSlide = freshSlides[freshIndex.value]
  const params = new URLSearchParams({
    text: `Halo, saya ingin memesan ${currentSlide.title}`
  })
  window.open(`https://wa.me/6285779983483?${params.toString()}`, '_blank')
}

const currentSection = ref(0)
const isBottomSheetOpen = ref(false)
const selectedProduct = ref<{ title: string; price: string } | null>(null)

const handleScroll = (event: Event) => {
  const target = event.target as HTMLElement
  const scrollPosition = target.scrollTop
  const windowHeight = window.innerHeight
  
  // Determine which section is currently visible
  currentSection.value = Math.round(scrollPosition / windowHeight)
}

const openOrderOptions = (product: { title: string; price: string }) => {
  selectedProduct.value = product
  isBottomSheetOpen.value = true
}

const closeBottomSheet = () => {
  isBottomSheetOpen.value = false
  selectedProduct.value = null
}

const orderViaWhatsApp = () => {
  if (!selectedProduct.value) return
  const params = new URLSearchParams({
    text: `Halo, saya ingin memesan pempek`
  })
  window.open(`https://wa.me/6285779983483?${params.toString()}`, '_blank')
  closeBottomSheet()
}

const orderViaGrabFood = () => {
  // Replace with your actual Grab Food link
  window.open('https://food.grab.com/your-restaurant-link', '_blank')
  closeBottomSheet()
}

const orderViaGoFood = () => {
  // Replace with your actual Go Food link
  window.open('https://gofood.link/a/QTcZiz7', '_blank')
  closeBottomSheet()
}

const orderViaShopeeFood = () => {
  // Replace with your actual Shopee Food link
  window.open('https://shopee.co.id/food/your-restaurant-link', '_blank')
  closeBottomSheet()
}

const scrollToFrozenProducts = () => {
  const section = document.getElementById('frozen-products')
  if (section) {
    section.scrollIntoView({ behavior: 'smooth' })
  }
}
const scrollToWelcome = () => {
  const section = document.getElementById('welcome')
  if (section) {
    section.scrollIntoView({ behavior: 'smooth' })
  }
}

const scrollToFreshProducts = () => {
  const section = document.getElementById('fresh-products')
  if (section) {
    section.scrollIntoView({ behavior: 'smooth' })
  }
}

onMounted(() => {
  // Add smooth scrolling behavior
  document.documentElement.style.scrollBehavior = 'smooth'
})

onBeforeUnmount(() => {
  document.documentElement.style.scrollBehavior = 'auto'
})
</script>

<template>
  <div class="h-screen overflow-y-auto snap-y snap-mandatory bg-white" @scroll="handleScroll">
    <!-- Floating Navbar -->
    <div 
      class="fixed top-0 left-0 right-0 z-20 flex items-center justify-center px-4 pb-3 pt-5 bg-[#f9f1e6] backdrop-blur-sm w-full h-[60px] transition-all duration-300"
      :class="currentSection > 0 ? 'opacity-100 translate-y-0' : 'opacity-0 -translate-y-full'"
    >
      <div @click="scrollToWelcome()">
        <img src="@/assets/images/logohd-removebg-preview.png" alt="Logo" class="h-[60px]">
      </div>
    </div>

    <!-- Welcome Section -->
    <section id="welcome" class="h-screen w-full flex flex-col snap-start snap-always bg-gradient-to-b from-[#f9f1e6] to-[#f4e6d0] relative px-6">
      <div class="flex flex-col items-center justify-center h-full">
        <img src="@/assets/images/logohd-removebg-preview.png" alt="Logo" class="w-64 mb-8 animate-fade-in">
        <h1 class="text-4xl font-bold text-[#af603b] mb-4 text-center animate-fade-in-delay-1">Katalog Menu</h1>
        <div class="flex flex-col space-y-4 w-full px-6 animate-fade-in-delay-2">
          <button
            @click="scrollToFreshProducts"
            class="py-4 px-8 bg-[#af603b] text-white rounded-full text-lg font-semibold hover:bg-[#3a2419] transition-colors transform hover:scale-105 duration-300"
          >
            Pempek Goreng
          </button>
          <button
            @click="scrollToFrozenProducts"
            class="py-4 px-8 border-2 border-[#af603b] text-[#af603b] rounded-full text-lg font-semibold hover:bg-[#af603b] hover:text-white transition-colors transform hover:scale-105 duration-300"
          >
            Pempek Frozen
          </button>
        </div>
      </div>
    </section>

    <!-- Fresh Products Section -->
    <section id="fresh-products" class="h-screen w-full flex flex-col snap-start snap-always relative bg-white">
      <div 
        class="relative h-[57%] md:h-[70%] overflow-hidden"
        @touchstart="handleTouchStart"
        @touchmove="handleTouchMove"
        @touchend="handleTouchEndFresh"
      >
        <div
          class="flex transition-all duration-700 ease-in-out"
          :style="{ transform: `translateX(-${freshIndex * 100}%)` }"
        >
          <div v-for="(slide, i) in freshSlides" :key="i" class="w-full flex-none h-[57%] md:h-[70%] relative overflow-hidden">
              <img :src="slide.img" alt="Slide Image" class="w-full h-full relative md:aspect-[16/9] lg:aspect-[16/7] md:object-cover" style="left: 0; top: -80%;"  />
          </div>
        </div>
        <div class="absolute bottom-0 w-full h-10 bg-gradient-to-b from-transparent to-[#f4e6d0]/95 backdrop-blur-sm"></div>
      </div>

      <div class="flex-1 flex flex-col items-center pb-8 bg-gradient-to-b from-[#f4e6d0] to-white pt-3">
        <div class="flex space-x-2 mb-4">
          <span
            v-for="(slide, i) in freshSlides"
            :key="'dot' + i"
            class="w-2 h-2 rounded-full transition-colors duration-300"
            :class="freshIndex === i ? 'bg-[#4b2f22]' : 'bg-[#d9c4a0]'"
          ></span>
        </div>

        <div class="text-center px-6">
          <h1 class="text-3xl font-bold mb-2 text-[#4b2926]">
            {{ freshSlides[freshIndex].title }}
          </h1>
          <div class="relative">
            <p class="text-[#5c4639]/70 text-sm md:scrollbar-initial md:max-h-auto max-h-13 overflow-y-auto scrollbar-hide cs-mask-overflow" >
              {{ freshSlides[freshIndex].text }}
            </p>
          </div>
          <p class="text-[#5c4639] text-2xl font-semibold my-1">
              {{ freshSlides[freshIndex].price }}
          </p>
        </div>

        <div class="w-full px-6">
          <button
            @click="openOrderOptions(freshSlides[freshIndex])"
            class="order-now-button py-4 bg-[#4b2926] text-white rounded-full text-lg font-semibold hover:bg-[#3a2419] transition-all duration-300 press-effect cursor-pointer"
          >
            Pesan Sekarang
          </button>
        </div>
      </div>
    </section>

    <!-- Frozen Products Section -->
    <section id="frozen-products" class="h-screen w-full flex flex-col snap-start snap-always relative bg-white">
      <div 
        class="relative h-[57%] md:h-[70%] overflow-hidden"
        @touchstart="handleTouchStart"
        @touchmove="handleTouchMove"
        @touchend="handleTouchEndFrozen"
      >
        <div
          class="flex transition-all duration-700 ease-in-out"
          :style="{ transform: `translateX(-${frozenIndex * 100}%)` }"
        >
          <div v-for="(slide, i) in frozenSlides" :key="i" class="w-full flex-none h-[57%] md:h-[70%] relative overflow-hidden">
              <img :src="slide.img" alt="Slide Image" class="w-full h-full relative md:aspect-[16/9] lg:aspect-[16/7] md:object-cover frozen-object-position" style="left: 0; top: -80%; "  />
          </div>
        </div>
        <div class="absolute bottom-0 w-full h-10 bg-gradient-to-b from-transparent to-[#b1b3b9]/95 backdrop-blur-sm"></div>
      </div>

      <div class="flex-1 flex flex-col items-center pb-8 bg-gradient-to-b from-[#b1b3b9] to-white pt-3">
        <div class="flex space-x-2 mb-4">
          <span
            v-for="(slide, i) in frozenSlides"
            :key="'dot' + i"
            class="w-2 h-2 rounded-full transition-colors duration-300"
            :class="frozenIndex === i ? 'bg-[#4b2f22]' : 'bg-[#d9c4a0]'"
          ></span>
        </div>

        <div class="text-center px-6">
          <h1 class="text-3xl font-bold mb-2 text-[#6273a6]">
            {{ frozenSlides[frozenIndex].title }}
          </h1>
          <div class="relative">
            <p class="text-[#5c4639]/70 text-sm md:scrollbar-initial md:max-h-auto max-h-13 overflow-y-auto scrollbar-hide cs-mask-overflow " >
              {{ frozenSlides[frozenIndex].text }}
            </p>
          </div>
          <p class="text-[#5c4639] text-2xl font-semibold my-1">
              {{ frozenSlides[frozenIndex].price }}
          </p>
        </div>

        <div class="w-full px-6">
          <button
            @click="openOrderOptions(freshSlides[freshIndex])"
            class="order-now-button py-4 bg-[#6273a6] text-white rounded-full text-lg font-semibold hover:bg-[#6273a6]/90 transition-all duration-300 press-effect cursor-pointer"
          >
            Pesan Sekarang
          </button>
        </div>
      </div>
    </section>

    <!-- Second Page Section -->
    <!-- About Section -->
    <section class="h-screen w-full flex flex-col snap-start snap-always bg-[#f9f1e6] px-6 py-20">
      <div class="flex flex-col items-center justify-center h-full pt-15">
        <h2 class="text-4xl font-bold text-[#af603b] mb-8">Tentang Kami</h2>
        <p class="text-[#5c4639] text-lg text-center mb-8">
          Selamat datang di rumah pempek keluarga kami. Resep yang kami gunakan adalah warisan turun-temurun 
          yang telah kami jaga keasliannya selama beberapa generasi. Setiap pempek dibuat dengan penuh 
          perhatian dan cinta, menghadirkan cita rasa otentik yang khas dari keluarga kami.
        </p>
        <div class="grid grid-cols-2 gap-4 w-full max-w-md">
          <div class="bg-white p-4 rounded-lg shadow-md text-center hover-scale">
            <h3 class="text-[#af603b] font-semibold mb-2">Kualitas Premium</h3>
            <p class="text-[#5c4639]/70 text-sm">Bahan berkualitas, menggunakan tenggiri premium </p>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md text-center hover-scale">
            <h3 class="text-[#af603b] font-semibold mb-2">Pengiriman Cepat</h3>
            <p class="text-[#5c4639]/70 text-sm">Pelayanan pengiriman yang cepat dan andal</p>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md text-center hover-scale">
            <h3 class="text-[#af603b] font-semibold mb-2">Dibuat Fresh</h3>
            <p class="text-[#5c4639]/70 text-sm">Memastikan kebersihan setiap bahan</p>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md text-center hover-scale">
            <h3 class="text-[#af603b] font-semibold mb-2">Rasa Otentik</h3>
            <p class="text-[#5c4639]/70 text-sm">Cita rasa asli resep keluarga</p>
          </div>
        </div>
      </div>
    </section>    <!-- Bottom Sheet -->
    <div
      v-if="isBottomSheetOpen"
      class="fixed inset-0 z-50 transition-all duration-300"
      :class="isBottomSheetOpen ? 'backdrop-blur-sm' : 'bg-opacity-0'"
      @click="closeBottomSheet"
    >
      <div
        class="absolute bottom-0 left-0 right-0 bg-white rounded-t-3xl p-6 animate-slide-up"
        style="max-height: 70vh"
        @click.stop
      >
        <!-- Handle/Pill -->
        <div class="w-12 h-1 bg-gray-300 rounded-full mx-auto mb-6"></div>

        <!-- Title -->
        <div class="text-center mb-6 animate-scale-in" style="animation-delay: 0.05s">
          <!-- <h3 class="text-xl font-bold text-[#af603b] mb-2">Order Options</h3>
          <p class="text-[#5c4639]/70 text-sm">
            {{ selectedProduct?.title }}
          </p>
          <p class="text-[#5c4639] font-semibold animate-bounce-subtle">
            {{ selectedProduct?.price }}
          </p> -->
        </div>

        <!-- Options -->
        <div class="space-y-4">
          <!-- WhatsApp -->
          <button
            @click="orderViaWhatsApp"
            class="w-full py-4 px-6 bg-[#25D366] text-white rounded-xl font-semibold flex items-center justify-center space-x-2 hover:bg-opacity-90 transition-all duration-300 hover-scale press-effect animate-scale-in"
            style="animation-delay: 0.1s"
          >
            <span>Order via WhatsApp</span>
          </button>


          <!-- GoFood -->
          <button
            @click="orderViaGoFood"
            class="w-full py-4 px-6 bg-[#00AA13] text-white rounded-xl font-semibold flex items-center justify-center space-x-2 hover:bg-opacity-90 transition-all duration-300 hover-scale press-effect animate-scale-in"
            style="animation-delay: 0.3s"
          >
            <span>Order via GoFood</span>
          </button>

        </div>

        <!-- Cancel Button -->
        <button
          @click="closeBottomSheet"
          class="w-full py-4 px-6 mt-4 border-2 border-[#af603b] text-[#af603b] rounded-xl font-semibold hover:bg-[#af603b] hover:text-white transition-all duration-300 hover-scale press-effect animate-scale-in"
          style="animation-delay: 0.5s"
        >
          Cancel
        </button>
      </div>
    </div>
  </div>
</template>

<style>
.order-now-button {
      position: absolute;
      bottom: 70px;
      left: 50%;
      transform: translateX(-50%);
      width: 90%;
}
@media (width < 48rem) { 
  .cs-mask-overflow {
    mask-image: linear-gradient(to bottom, black 60%, transparent 100%);
  }
}
@media (width >= 48rem) { 
  .frozen-object-position {
    object-position: 0 70%;   
  }
  .order-now-button {
      bottom: 50px;
  }
}

@keyframes fadeIn {
  from { 
    opacity: 0; 
    transform: translateY(20px); 
  }
  to { 
    opacity: 1; 
    transform: translateY(0); 
  }
}

@keyframes slideUp {
  from { 
    transform: translateY(100%); 
  }
  to { 
    transform: translateY(0); 
  }
}

@keyframes scaleIn {
  from { 
    transform: scale(0.95); 
    opacity: 0; 
  }
  to { 
    transform: scale(1); 
    opacity: 1; 
  }
}

@keyframes bounce {
  0%, 100% { 
    transform: translateY(0); 
  }
  50% { 
    transform: translateY(-5px); 
  }
}

.animate-fade-in {
  animation: fadeIn 1s ease-out forwards;
}

.animate-fade-in-delay-1 {
  animation: fadeIn 1s ease-out 0.3s forwards;
  opacity: 0;
}

.animate-fade-in-delay-2 {
  animation: fadeIn 1s ease-out 0.6s forwards;
  opacity: 0;
}

.animate-slide-up {
  animation: slideUp 0.5s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

.animate-scale-in {
  animation: scaleIn 0.4s ease-out forwards;
}

.animate-bounce-subtle {
  animation: bounce 2s ease-in-out infinite;
}

.hover-scale {
  transition: transform 0.2s ease;
}

.hover-scale:hover {
  transform: scale(1.02);
}

.press-effect:active {
  transform: scale(0.98);
}
</style>
