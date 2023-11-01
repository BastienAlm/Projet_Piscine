<template>
    <aside class="sidebar">
      <div class="sidebar-header">
        <h2>Sidebar</h2>
      </div>
      <ul class="sidebar-menu">
        <li @click="navigateTo('UserId')">User Id</li>
        <li @click="navigateTo('CreateUser')">Create User</li>
        <li @click="navigateTo('UpdateUser')">Update User</li>
        <li @click="navigateTo('DeleteUser')">Delete User</li>
        <li @click="navigateTo('WorkingTime')">Working Time</li>
      </ul>
    </aside>
  </template>
  
  <script>
  export default {
    methods: {
      navigateTo(routeName) {
        this.$router.push({ name: routeName });
      },
    },
  };
  </script>
  
  <style scoped>
  .sidebar {
    width: 250px;
    background: #333;
    color: #fff;
  }
  
  .sidebar-header {
    padding: 20px;
    text-align: center;
  }
  
  .sidebar-menu {
    list-style: none;
    padding: 0;
  }
  
  .sidebar-menu li {
    padding: 10px;
    cursor: pointer;
  }
  
  .sidebar-menu li:hover {
    background: #555;
  }
  </style>