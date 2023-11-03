<template>
    <div class="nav">
        <a href="#">User ID</a>
        <a href="#">Create User</a>
        <a href="#">Update User</a>
        <a href="#">Delete User</a>
        <a href="#">Working time</a>
    </div>
</template>
<script>
export default {
    name: 'Navbar'
}
</script>
<style>
.nav{
    background-color: #333;
    overflow: hidden;
    margin-bottom: 15px;
}
.nav a {
    float: left;
    color: lightblue;
    padding: 14px 16px;
    text-align: center;
    font-size: 15px;
    text-decoration: none;
}
.nav a:hover{
    background-color: lightblue;
    color: #333
}
</style>