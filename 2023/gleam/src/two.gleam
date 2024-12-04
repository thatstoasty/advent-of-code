import gleam/list
import gleam/string
import gleam/int
import gleam/result
import gleam/io
import simplifile

const red_limit = 12
const green_limit = 13
const blue_limit = 14

// Part 1
fn assess_pull(pull: String) -> Bool {
    let pull_info = string.split(pull, " ")
    let assert Ok(count) = list.first(pull_info)
    |> result.try(int.parse(_))

    let assert Ok(color) = list.last(pull_info)
    case color {
        "red" -> count > red_limit
        "green" -> count > green_limit
        "blue" -> count > blue_limit
        _ -> panic("Invalid color")
    }
}

fn assess_round(round: String) -> Bool {
    let pulls = string.split(round, ", ")
    list.any(pulls, assess_pull)
}

fn assess_game(sum: Int, game: List(String)) -> Int {
    let assert Ok(id) = list.first(game)
    |> result.try(int.parse(_))

    let assert Ok(rounds) = list.last(game)
    |> result.map(string.split(_, on: "; "))

    case list.any(rounds, assess_round) {
        True -> sum + 0
        False -> sum + id
    }
}

pub fn solve_part_one() {
    let assert Ok(input) = simplifile.read(from: "src/data/two.txt")
    string.split(input, "\n")
    |> list.map(_, string.split(_, ": "))
    |> list.map(_, list.map(_, string.replace(_, each: "Game ", with: "")))
    |> list.fold(_, 0, assess_game)
    |> io.debug(_)
}

// Part 2
fn assess_pull_two(max: Max, pull: String) -> Max {
    let pull_info = string.split(pull, " ")
    let assert Ok(count) = list.first(pull_info)
    |> result.try(int.parse(_))

    let assert Ok(color) = list.last(pull_info)

    case color {
        "red" if count > max.red -> Max(red: count, green: max.green, blue: max.blue)
        "green" if count > max.green -> Max(red: max.red, green: count, blue: max.blue)
        "blue" if count > max.blue -> Max(red: max.red, green: max.green, blue: count)
        _ -> panic("Invalid color")
    }
}

fn assess_round_two(round: String, max: Max) -> Max {
    let pulls = string.split(round, ", ")
    list.fold(pulls, max, assess_pull_two)
}

pub type Max {
  Max(red: Int, green: Int, blue: Int)
}

fn assess_game_two(sum: Int, game: List(String)) -> Int {
    let assert Ok(id) = list.first(game)
    |> result.try(int.parse(_))

    let assert Ok(rounds) = list.last(game)
    |> result.map(string.split(_, on: "; "))

    let max = Max(red: 0, green: 0, blue: 0)
    list.map(rounds, assess_round_two(_, max))
    |> io.debug
    0
}

pub fn solve_part_two() {
    let assert Ok(input) = simplifile.read(from: "src/data/two.txt")
    string.split(input, "\n")
    |> list.map(_, string.split(_, ": "))
    |> list.map(_, list.map(_, string.replace(_, each: "Game ", with: "")))
    |> list.fold(_, 0, assess_game_two)
    |> io.debug(_)
}