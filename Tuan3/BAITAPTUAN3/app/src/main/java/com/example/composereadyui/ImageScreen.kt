package com.example.composereadyui

import android.content.Intent
import android.net.Uri
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import coil.compose.AsyncImage
import androidx.compose.ui.res.painterResource

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ImageScreen(navController: NavController) {
    val context = LocalContext.current

    // 🖼️ Danh sách ảnh + link tương ứng
    val images = listOf(
        Pair(
            "https://www.kindpng.com/picc/m/198-1980065_jetpack-compose-hd-png-download.png\n",
            "https://www.kindpng.com/"
        ),
        Pair(
            "https://cdn.pixabay.com/photo/2017/01/20/15/06/fruit-1995056_1280.jpg",
            "https://developer.mozilla.org/en-US/docs/Web/JavaScript"
        )
    )

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Images & Links") },
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(
                            painter = painterResource(id = R.drawable.ic_launcher_foreground),
                            contentDescription = "Back"
                        )
                    }
                }
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .padding(padding)
                .fillMaxSize()
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {

            // 🔁 Lặp qua danh sách ảnh
            images.forEach { (imageUrl, linkUrl) ->
                AsyncImage(
                    model = imageUrl,
                    contentDescription = null,
                    contentScale = ContentScale.Fit,
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(200.dp)
                        .padding(bottom = 8.dp)
                )

                Text(
                    text = linkUrl,
                    color = Color.Blue,
                    fontSize = 16.sp,
                    textAlign = TextAlign.Center,
                    modifier = Modifier
                        .clickable {
                            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(linkUrl))
                            context.startActivity(intent)
                        }
                        .padding(bottom = 24.dp)
                )
            }
        }
    }
}
