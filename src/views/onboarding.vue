<template>
  <ion-header translucent>
  </ion-header>
  <ion-content fullscreen>
    <ion-slides ref="slider" :options="slideOpts" :pager="true">
      <ion-slide>
        <img src="../../resources/onboarding1.png">
        <h1>Start</h1>
        <p>
          Choose from 1 to 3 boxes into which balls will fall and you will receive gold for this
        </p>
      </ion-slide>
      <ion-slide>
        <img src="../../resources/onboarding2.png">
        <h1>Profile</h1>
        <p>
          Get more gold to buy new skins and the game will become even brighter.
        </p>
      </ion-slide>
      <ion-slide>
        <img src="../../resources/onboarding3.png">
        <h1>Rating</h1>
        <p>
          Earn as much gold as possible to be the first in the leaderboard.
        </p>
      </ion-slide>
    </ion-slides>
    <div class="button-container">
      <ion-button
        @click="nextSlide()"
        expand="block">
          Continue
      </ion-button>
    </div>
  </ion-content>
</template>

<script lang="ts">
  import { IonSlides, IonSlide, IonButton, IonItem, IonLabel } from '@ionic/vue';
  import { defineComponent, inject, ref } from 'vue';
  import Portals from '@ionic/portals';

  export default defineComponent({
    name: 'onboarding',
    components: { IonSlides, IonSlide, IonButton, IonItem, IonLabel },
    setup() {
      const slideOpts = {
        initialSlide: 0,
        speed: 400
      };
      const slider = ref();
      const nextSlide = () => {
        slider.value.$el.isEnd().then((isLastIndex: Boolean) => {
          if (isLastIndex) {
            Portals.publish({ topic: "continue", data: "success" });
          } else {
            slider.value.$el.slideNext(400);
          }
        }); 
      };
      return { slideOpts, slider, nextSlide }
    }
  });
</script>

<style>

  :root {
    --ion-safe-area-top: 20px;
    --ion-safe-area-bottom: 22px;
    background-color: #131312;
  }

  h1 {
    color: #fff;
  }

  p {
    padding: 0 40px;
    font-size: 18px;
    line-height: 1.5;
    color: var(--ion-color-step-600, #60646b);
  }

  ion-slides {
    height: 80%;
  }

  ion-button {
    height: 52px;
  }

  .swiper-slide {
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }

  .swiper-slide h1 {
    margin-top: 2.8rem;
    font-size: 40px;
    font-weight: bolder;
  }

  .swiper-slide img {
    max-height: 50%;
    max-width: 80%;
    margin: 60px 0 40px;
    pointer-events: none;
  }

  .button-container {
    width: 100%;
    height: 20%;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .button-container ion-button {
    width: 90%;
  }

</style>