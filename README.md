# Asm ids kit (X86_32)

## Task 1 - Parantezinator

Sistemul se bazează pe anumite reguli care trebuie scrise într-un fișier de configurare.
Un aspect important al verificării acestor reguli este parantezarea diferitelor elemente ale regulii.

În acest task va trebui să implementați o funcție care verifică dacă un șir de paranteze formează o parantezare corectă, adică dacă toate parantezele deschise sunt închise corespunzător.

De exemplu, șirul "()()" este o parantezare corectă, dar "{{}" nu este, pentru ca se închide doar o paranteză, și nici "{[}]" nu este, pentru că parantezele nu sunt închise corespunzător.

Funcția pe care o veți implementa va returna 0 daca nu sunt probleme de parantezare (dacă sunt parantezele puse bine) si 1 altfel.

## Task 2 - Divide et impera

Considerand ca s-a incalzit suficient cu primul task, Zoly a decis ca nu are nevoie de o pauza (bine meritata de altfel) si ca vrea sa termine mai repede ~~tema~~ sistemul revolutionar de intrusion detection. Neavand insa incredere in alti programatori, s-a gasit nevoita sa reimplementeze cativa algoritmi necesari ei: *quick sort* si *binary search*. Si doar pentru a arata ca poate, a hotarat sa implementeze variantele *recursive*!

În acest task veți implementa cei doi algoritmi: *quick sort* și *binary search*.

*Note:* ambele implementări trebuie să fie recursive, NU iterative.

Pentru a rula toate testele, rulați executabilul generat fără niciun argument. Pentru a rula un singur test, apăsați unul dintre keyword-urile `qsort` și `bsearch` ca prim argument, urmat de numărul testului.
De exemplu:

```bash
# rulează toate testele
$ ./checker

# rulează un singur test
$ ./checker qsort 3
$ ./checker bsearch 10
```

---

### Exercițiul 1

Pentru acest exercițiu aveți de implementat funcția `quick_sort()` în fișierul `subtask_1.asm`.

Această funcție are semnătura de mai jos. În urma rulării ei, numerele stocate în `buff` vor fi sortate crescător. `start` și `end` reprezintă indexul primului, respectiv ultimului element (începând de la 0).

```c
void quick_sort(int32_t *buff, uint32_t start, uint32_t end);
```

Dacă nu sunteți familiari cu algoritmul *quick sort*, aruncați o privire [aici](https://www.programiz.com/dsa/quick-sort) sau întrebați un prieten ;)

---

### Exercițiul 2

În acest exercițiu va trebui sa implementați funcția `binary_search()` în fișierul `subtask_2.asm`.

Această funcție va returna poziția elementului `needle` in cadrul array-ului `buff`. Căutarea va avea loc între elementele indexate `start` și `end` (inclusiv). Dacă `needle` nu se găsește în `buff`, funcția va returna `-1`. Este garantat faptul că elementele din `buff` sunt sortate crescător.

Observați în cadrul semnăturii funcției atributul [fastcall](https://gcc.gnu.org/onlinedocs/gcc-4.7.0/gcc/Function-Attributes.html).
Acesta va modifica calling convention-ul utilizat in `check.c`. Țineți cont de acest lucru când implementați funcția (și când faceți apelurile recursive).

```c
int32_t __attribute__((fastcall))
binary_search(int32_t *buff, uint32_t needle, uint32_t start, uint32_t end);
```

## Task 3 - Depth first search

Pentru ca Zoly să verifice că drumul pe care e transmis un pachet este legitim, se va realiza o cautare in topologia rețelei. Protocolul de comunicație garantează trimiterea pachetelor folosind algoritmul de căutare în adâncime. Astfel, știind sursa pachetului, putem găsi calea legitimă către toate celelalte gazde din rețea.

În acest task veți implementa algoritmul cunoscut de la SDA de cautare pe grafuri, depth first search.

### Algoritmul dfs

Precum sunteți deja familiari, depth first search implică cautare în adâncime pe grafuri, pornind de la un nod sursă dat. Algoritmul marchează nodul inițial ca fiind visitat și se aplică recursiv pe toți vecini lui. Algoritmul va continua, evitând nodurile marcate ca vizitate.

Luăm graful următor ca exemplu:

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Directed_graph_no_background.svg/1280px-Directed_graph_no_background.svg.png" alt="err" width="300"/>

Dacă nodul sursă este 1, atunci o posibilă cautare dfs ar fi urmatoarea:

- Nodul 1 este vizitat.
- Nodul 2 este vizitat.
- Nodul 2 nu are vecini, ne întoarcem la nodul 1.
- Nodul 3 este vizitat.
- Nodul 2 a fost deja vizitat, vizitam nodul 4.
- Nodul 3 a fost deja vizitat, iar nodul 4 nu mai are vecini, deci ne întoarcem la nodul 3.
- Nodul 3 nu mai are vecini, ne întoarcem la nodul 1.
- Nodul 1 nu mai are vecini, se încheie căutarea.

Dfs-ul poate avea mai multe căutari valide, în funcție de ordinea în care alegem să vizităm vecinii. În cazul nostru, celelalte posibilități de căutare ar fi {1, 3, 2, 4} și {1, 3, 4, 2}.

### API

În cadrul task-ului, nodurile sunt reprezentate sub forma unui id de tip `uint32_t` (unsigned int).
Pentru a obține vecinii unui nod, se apelează funcția `expand` cu următoarea semnătură:

```c
neighbours_t expand(uint32_t node);
```

Aceasta returnează **adresa** unei structuri care conține vecinii nodului în felul următor:

```x86asm
struc neighbours_t
    .num_neighs resd 1  ; Numărul de vecini.
    .neighs resd 1      ; Adresa vectorul cu `num_neighs` vecini.
endstruc
```

### Cerința

Vi se cere să implementați **recursiv** funcția `dfs()` din fișierul `dfs.asm`, care are următoarea semnătură:

```c
void dfs(uint32_t node, neighbours_t *(*expand)(uint32_t node));
```

Aceasta primește ca parametru nodul sursă și adresa funcției `expand` și se cere să implementați algoritmul de dfs și să printați nodurile în momentul în care le viziați.

## Checker

Pentru a folosi checker-ul `local_checker.py`, este necesar să aveți Python3 instalat.

Pentru a vedea lista de argumente posibile a script-ului:

```bash
    python3 local_checker.py --help
```

Pentru a rula toate testele:

```bash
    python3 local_checker.py --all
```
