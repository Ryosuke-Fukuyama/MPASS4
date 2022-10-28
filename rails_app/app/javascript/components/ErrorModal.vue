<template>
  <transition name="modal" appear>
    <div class="modal__overlay">
      <div class="modal__window">
        <div class="modal__content">
          <button @click="closeClick()">× ERROR</button>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
export default {
  // name: 'ErrorModal',
  data:() => {
    return {
      modalFlag: ''
    }
  },

  methods: {
    closeClick() {
      this.$emit('close-click')
    }
  }
}
</script>

<style>
  button {
  color: red;
  }

  /* .modal__overlay {
  }

  .modal__window {
  }

  .modal__content {
  }

  .modal-enter-active,
  .modal-leave-active {
  }

  .modal-leave-active {
  }

  .modal-enter,
  .modal-leave-to {
  } */
</style>
