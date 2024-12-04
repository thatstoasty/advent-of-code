use std::fs::read_to_string;


fn main() {
    // let mut s = String::new();
    let mut a: Vec<i64> = Vec::new();
    let mut b: Vec<i64> = Vec::new();
    for line in read_to_string("data/input/01.txt").unwrap().lines() {
        let pair: Vec<&str> = line.split("   ").collect();
        a.push(pair[0].to_string().parse().unwrap());
        b.push(pair[1].to_string().parse().unwrap());
    };

    a.sort();
    b.sort();
    let mut result: i64 = 0;
    for i in 0..a.len() {
        result += (b[i] - a[i]).abs();
    }
    println!("{}", result);
}
