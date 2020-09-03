<?php
function recaptcha(){
	$Hsn = '01';
	//$sess_ThsrHsn = new Container('Hilai'.$Hsn);
	$string = '';
	// Create reCaptcha String
	for ($i = 0; $i < 6; $i++) {
		switch(rand(0,5)){
			/*case 0:$string .= chr(rand(50, 53));break;
			case 1:$string .= chr(rand(69, 72));break;
			case 2:$string .= chr(rand(80, 82));break;
			case 3:$string .= chr(rand(84, 86));break;
			case 4:$string .= chr(rand(88, 89));break;
			case 5:$string .= chr(rand(55, 56));break;
			*/
			case 0:$string .= rand(0, 9);break;
			case 1:$string .= rand(0, 9);break;
			case 2:$string .= rand(0, 9);break;
			case 3:$string .= rand(0, 9);break;
			case 4:$string .= rand(0, 9);break;
			case 5:$string .= rand(0, 9);break;
		}
	}
	//Zend_Session::start();
	//$userProfileNamespace = new Zend_Session_Namespace('userProfileNamespace');
	session_start();	
	unset($_SESSION['random_number']);
	$_SESSION["random_number"] = null;
	$_SESSION['random_number'] = $string;
	
	//var_dump($_SESSION['random_number']);
	//$sess_ThsrHsn->offsetSet('random_number', $string);
	
	$RETXT = $_SESSION['random_number'];
	
	$dir = 'fonts/';

	// Set Font 
	switch(rand(1,4)){
		case 1:$font = "Capture it 2.ttf"; break;
		case 2:$font = "Molot.otf";break;
		case 3:$font = 'Walkway rounded.ttf';break;
		case 4:$font = 'AHGBold.ttf';break;
	}
	$image = imagecreatetruecolor(120, 35);
	// set Font Color
	switch(rand(1,3)){
		case 1:$color = imagecolorallocate($image, 113, 193, 217);break;
		case 2:$color = imagecolorallocate($image, 163, 197, 82);break;
		case 3:$color = imagecolorallocate($image, 123, 107, 182);break;
	}
	// set Background image
	switch(rand(1,2)){
		case 1:$newim = imagecreatefromjpeg($dir.'bg3.jpg');break;
		case 2:$newim = imagecreatefromjpeg($dir.'bg4.jpg');break;
	}
	//var_dump($newim);
	$white = imagecolorallocate($image, 255, 255, 255); // background color white
	imagefilledrectangle($image,0,0,399,99,$white);
	imagecopyresized($image, $newim, 0, 0, 0, 0,
					 120, 35, imagesx($newim), imagesy($newim));
	imagettftext ($image, 22, 2, 5, 30, $color, $dir.$font,$RETXT );
	header('Content-Type: image/png');
	imagepng($image);
	imagedestroy($image);
		
	return $image;
}
recaptcha();
?>		