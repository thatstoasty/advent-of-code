use std::fs::read_to_string;


fn part_one() {
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

fn part_two() {
    let mut a: Vec<i64> = Vec::new();
    let mut b: Vec<i64> = Vec::new();
    for line in read_to_string("data/input/01.txt").unwrap().lines() {
        let pair: Vec<&str> = line.split("   ").collect();
        a.push(pair[0].to_string().parse().unwrap());
        b.push(pair[1].to_string().parse().unwrap());
    };

    let mut result: i64 = 0;
    for i in a.iter() {
        result += i * b.iter().filter(|&x| *x == *i).count() as i64;
    }
    println!("{}", result);
}

fn main() {
    part_one();
    part_two();
}
