<template>
  <transition name="modal" appear>
    <div class="modal__overlay">
      <div class="modal__window">
        <div class="modal__content">
           ERROR!
          <button @click="closeClick()">×</button>
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
.modal__overlay {
    /* display: flex;
    align-items: center;
    justify-content: center;
    position: fixed;
    top: 0;
    left: 0; */
    /* height: 100%; */
    width: fit-content;
    background: rgb(145, 145, 145);
    z-index: 1;
  }

  .modal__window {
    /* height: 30%; */
    width: fit-content;
    overflow: hidden;
    z-index: 2;
  }

  .modal__content {
    color: red;
    font-size: 13px;
    /* padding: 30px; */
  }

.modal-enter-active,
.modal-leave-active {
  /* transition: opacity 0.4s;
  .modal__window {
    transition: opacity 0.4s, transform 0.4s;
  } */
}
.modal-leave-active {
  /* transition: opacity 0.6s ease 0.4s; */
}
.modal-enter,
.modal-leave-to {
  /* opacity: 0;
  .modal__window {
    opacity: 0;
    transform: translateY(-20px);
  } */
}
</style>
