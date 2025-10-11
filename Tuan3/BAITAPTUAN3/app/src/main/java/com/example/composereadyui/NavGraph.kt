package com.example.composereadyui

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable

@Composable
fun NavGraph(navController: NavHostController) {
    NavHost(
        navController = navController,
        startDestination = "home"
    ) {
        // Trang chính
        composable("home") { HomeScreen(navController) }

        // Trang danh sách UI Components
        composable("components") { ComponentsScreen(navController) }

        // Trang Text Detail
        composable("textDetail") { TextDetailScreen(navController) }

        // Trang Image
        composable("images") { ImageScreen(navController) }

        // Trang TextField
        composable("textField") { TextFieldScreen(navController) }

        // Trang Row Layout
        composable("rowLayout") { RowLayoutScreen(navController) }
    }
}
