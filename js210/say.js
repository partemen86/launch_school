function reverse(input) {
  if (Array.isArray(input)) {
  	return reverseArray(input);
  } else {
  	return reverseString(input);
  }
}

function reverseArray(arr) {
	result = [];
	arr.forEach(element => result.unshift(element));
	return result;s
}

function reverseString(str) {
	console.log(str.reverse);
	return str.reverse;
}


console.log(reverse('Helo'));           // "olleH"
console.log(reverse('a'));              // "a"
console.log(reverse([1, 2, 3, 4]));      // [4, 3, 2, 1]
console.log(reverse([]));                // [

const array = [1, 2, 3];
console.log(reverse(array));             // [3, 2, 1]
       