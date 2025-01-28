//! ch1

extern crate volatile;

use std::ptr::NonNull;
use volatile::VolatileRef;

fn main() {
	let mut an_integer = unsafe {
		let mut i = 666;
		let i_p = NonNull::new(&mut i as *mut _,).expect("ptr is null",);
		VolatileRef::new(i_p,)
	};
	let an_int_p = an_integer.as_mut_ptr();
	unsafe {
		*an_int_p.as_raw_ptr().as_ptr() += 111;
	}
	assert_eq!(777, an_integer.as_ptr().read());
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn volatile_add() {
		main();
	}
}
