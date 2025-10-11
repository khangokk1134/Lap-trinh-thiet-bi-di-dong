@file:OptIn(ExperimentalMaterial3Api::class)

package com.example.composereadyui

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController

@Composable
fun ComponentsScreen(navController: NavController) {
    Scaffold(
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("UI Components List") }
            )
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .padding(16.dp)
                .fillMaxSize(),
            verticalArrangement = Arrangement.Top,
            horizontalAlignment = Alignment.Start
        ) {
            // --- Display section ---
            SectionTitle("Display")

            ComponentItem(
                title = "Text",
                desc = "Displays text",
                onClick = { navController.navigate("textDetail") }
            )
            ComponentItem(
                title = "Image",
                desc = "Displays an image",
                onClick = { navController.navigate("images") }
            )

            Spacer(modifier = Modifier.height(16.dp))

            // --- Input section ---
            SectionTitle("Input")

            ComponentItem(
                title = "TextField",
                desc = "Input field for text",
                onClick = { navController.navigate("textField") } // ✅ thêm sự kiện
            )
            ComponentItem(
                title = "PasswordField",
                desc = "Input field for passwords"
            )

            Spacer(modifier = Modifier.height(16.dp))

            // --- Layout section ---
            SectionTitle("Layout")

            ComponentItem(
                title = "Column",
                desc = "Arranges elements vertically"
            )
            ComponentItem(
                title = "Row",
                desc = "Arranges elements horizontally",
                onClick = { navController.navigate("rowLayout") } // ✅ thêm sự kiện
            )

            Spacer(modifier = Modifier.height(24.dp))

            // --- Extra section ---
            SectionTitle("Extra")

            ComponentItem(
                title = "Tự tìm hiểu",
                desc = "Thêm các thành phần khác mà bạn muốn"
            )
        }
    }
}

@Composable
fun SectionTitle(title: String) {
    Text(
        text = title,
        fontSize = 18.sp,
        fontWeight = FontWeight.Bold,
        color = Color.Black,
        modifier = Modifier.padding(bottom = 8.dp)
    )
}

@Composable
fun ComponentItem(title: String, desc: String, onClick: (() -> Unit)? = null) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color(0xFFD6EAF8), shape = RoundedCornerShape(10.dp))
            .padding(12.dp)
            .clickable(enabled = onClick != null) { onClick?.invoke() }
    ) {
        Text(
            text = title,
            fontWeight = FontWeight.Bold,
            color = Color.Black,
            fontSize = 16.sp
        )
        Text(
            text = desc,
            color = Color.DarkGray,
            fontSize = 14.sp
        )
    }
    Spacer(modifier = Modifier.height(10.dp))
}
