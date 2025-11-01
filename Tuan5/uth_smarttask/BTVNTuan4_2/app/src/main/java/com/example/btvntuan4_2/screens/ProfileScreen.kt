package com.example.btvntuan4_2.screens

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.DateRange
import androidx.compose.material.icons.filled.Email
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import coil.compose.rememberAsyncImagePainter
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import java.text.SimpleDateFormat
import java.util.*
import androidx.compose.ui.graphics.vector.ImageVector
import com.google.firebase.firestore.SetOptions


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProfileScreen(navController: NavController) {
    val user = FirebaseAuth.getInstance().currentUser
    val firestore = FirebaseFirestore.getInstance()

    var name by remember { mutableStateOf(user?.displayName ?: "") }
    var email by remember { mutableStateOf(user?.email ?: "") }
    var photoUrl by remember { mutableStateOf(user?.photoUrl?.toString() ?: "") }
    var dateOfBirth by remember { mutableStateOf("Unknown") }
    var showDatePicker by remember { mutableStateOf(false) }

    // 🔹 Lấy ngày sinh từ Firestore (nếu đã lưu)
    LaunchedEffect(user) {
        user?.uid?.let { uid ->
            firestore.collection("users").document(uid)
                .get()
                .addOnSuccessListener { doc ->
                    dateOfBirth = doc.getString("dob") ?: "Unknown"
                }
        }
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Profile") },
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(Icons.Filled.ArrowBack, contentDescription = "Back")
                    }
                }
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // Ảnh đại diện
            if (photoUrl.isNotEmpty()) {
                Image(
                    painter = rememberAsyncImagePainter(photoUrl),
                    contentDescription = "Profile Picture",
                    modifier = Modifier
                        .size(100.dp)
                        .clip(CircleShape)
                        .border(2.dp, Color.Gray, CircleShape),
                    contentScale = ContentScale.Crop
                )
            } else {
                Box(
                    modifier = Modifier
                        .size(100.dp)
                        .clip(CircleShape)
                        .background(Color.Gray)
                )
            }

            Spacer(modifier = Modifier.height(24.dp))

            // Họ tên
            ProfileField(label = "Name", value = name, icon = Icons.Default.Person)
            Spacer(modifier = Modifier.height(12.dp))

            // Email
            ProfileField(label = "Email", value = email, icon = Icons.Default.Email)
            Spacer(modifier = Modifier.height(12.dp))

            // Ngày sinh
            ProfileField(
                label = "Date of Birth",
                value = dateOfBirth,
                icon = Icons.Default.DateRange,
                hasDropdown = true,
                onClick = { showDatePicker = true }
            )

            // Nút quay lại
            Spacer(modifier = Modifier.height(30.dp))
            Button(
                onClick = { navController.popBackStack() },
                modifier = Modifier.fillMaxWidth(),
                shape = RoundedCornerShape(8.dp)
            ) {
                Text("Back")
            }
        }

        // Hiển thị DatePickerDialog khi người dùng bấm chọn
        if (showDatePicker) {
            val datePickerState = rememberDatePickerState()

            DatePickerDialog(
                onDismissRequest = { showDatePicker = false },
                confirmButton = {
                    TextButton(onClick = {
                        showDatePicker = false
                        val millis = datePickerState.selectedDateMillis
                        if (millis != null) {
                            val date = SimpleDateFormat("dd/MM/yyyy", Locale.getDefault())
                                .format(Date(millis))
                            dateOfBirth = date

                            // 🔹 Lưu ngày sinh vào Firestore
                            user?.uid?.let { uid ->
                                firestore.collection("users").document(uid)
                                    .set(mapOf("dob" to date), SetOptions.merge())
                            }
                        }
                    }) {
                        Text("OK")
                    }
                },
                dismissButton = {
                    TextButton(onClick = { showDatePicker = false }) {
                        Text("Cancel")
                    }
                }
            ) {
                DatePicker(state = datePickerState)
            }
        }
    }
}

@Composable
fun ProfileField(
    label: String,
    value: String,
    icon: ImageVector,
    hasDropdown: Boolean = false,
    onClick: (() -> Unit)? = null
) {
    Column(modifier = Modifier.fillMaxWidth()) {
        Text(label, fontSize = 14.sp, fontWeight = FontWeight.Bold)
        Spacer(modifier = Modifier.height(4.dp))
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .height(50.dp)
                .clip(RoundedCornerShape(8.dp))
                .border(1.dp, Color.LightGray)
                .padding(horizontal = 12.dp)
                .clickable(enabled = hasDropdown, onClick = { onClick?.invoke() }),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(icon, contentDescription = null, tint = Color.Gray)
            Spacer(modifier = Modifier.width(12.dp))
            Text(value, fontSize = 16.sp)
        }
    }
}
