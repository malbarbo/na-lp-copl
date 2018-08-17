pub fn main() {
    let mut v = vec![10, 20, 30];
    let mut soma = 0;
    for &x in &v {
        soma += x;
        if x == 20 {
            v.push(1);
        }
    }
    assert_eq!(soma, 61);
}
