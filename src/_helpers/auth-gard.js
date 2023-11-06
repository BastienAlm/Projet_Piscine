// import router from '@/router'

let token = localStorage.getItem('token')
// export function authGuard(){
    

//     if(token){
//         return true
//     }

//     router.push('/login')
// }

export const isAuthenticated = () => {
    return !!token
}