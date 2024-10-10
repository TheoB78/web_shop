<template>
  <header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark nav-padding">
      <RouterLink class="navbar-brand" to="/">Web Shop</RouterLink>
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarText"
        aria-controls="navbarText"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarText">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <RouterLink to="/pc" class="nav-link">Produkte</RouterLink>
          </li>
          <li class="nav-item">
            <RouterLink to="/cart" class="nav-link">Warenkorb</RouterLink>
          </li>
          <li class="nav-item">
            <RouterLink to="/account" class="nav-link">Account</RouterLink>
          </li>
        </ul>
      </div>
    </nav>
  </header>
</template>

<script setup>
import { RouterLink } from 'vue-router'
</script>

<style>
.nav-padding {
  padding: 25px;
}
</style>
