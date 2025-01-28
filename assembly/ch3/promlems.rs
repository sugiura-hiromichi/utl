fn main() {
	println!(
		"ascii codes\nesc: {}\n7: {}\nG: {}\ng: {}",
		char::from_u32(0x1b).unwrap(),
		b'7',
		b'G',
		b'g'
	);
	let characters = ['さ', 'サ', 'ざ', 'ザ',];
	for c in characters.iter() {
		println!("{c} -> {}", *c as u32);
	}
}
