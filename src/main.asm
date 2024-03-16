.INCLUDE "header.asm"

.SEGMENT "ZEROPAGE"

.INCLUDE "registers.inc"

; Game Constant
STARTING_POS= $CF
P1XPOS = $58
P2XPOS = $A0
STATETITLE     = $00  ; displaying title screen
STATEPLAYING   = $01  ; move paddles/ball, check for collisions
STATEGAMEOVER  = $02  ; displaying game over screen

MAZEWIDTH = $04
MAZEHEIGHT = $10

; memory mapping
corner_up_left_1  = $0422 ; one square distance
corner_up_left_2  = $0443 ; +
corner_up_left_3  = $0464 ; |
corner_up_left_4  = $0485 ; |_ 2 square distance
corner_up_left_5  = $04A6 ; |
corner_up_left_6  = $04C7 ; |
corner_up_left_7  = $04E8 ; +
corner_up_left_8  = $0509 ; 3 square distance
corner_up_left_9  = $052A ; 4 and 5 square distance
corner_up_left_10 = $054B ; 6, 7, 8,  square distance
corner_up_left_11 = $056C ; 9, 10, 11, 12  square distance
corner_up_left_12 = $058D ; 13, 14, 15, 16, 17 square distance
corner_up_left_13 = $05AE ; 18, 19, 20, 21, 22, 23 square distance

corner_up_right_1  = $043D
corner_up_right_2  = $045C
corner_up_right_3  = $047B
corner_up_right_4  = $049A
corner_up_right_5  = $04B9
corner_up_right_6  = $04D8
corner_up_right_7  = $04F7
corner_up_right_8  = $0516
corner_up_right_9  = $0535
corner_up_right_10 = $0554
corner_up_right_11 = $0573
corner_up_right_12 = $0592
corner_up_right_13 = $05B1

middle_corner_up_left    = $05CF ; + 24, 25, 26, 27, 28, 29, 30 square distance
middle_corner_up_right   = $05D0 ; |_ first see square
middle_corner_down_left  = $05EF ; |
middle_corner_down_right = $05F0 ; +

s2_up_left        = $05AF ; +
s2_up_right       = $05B0 ; |
s2_down_left      = $060F ; |
s2_down_right     = $0610 ; |_ second see square
s2_middle_1_left  = $05CE ; |
s2_middle_2_left  = $05EE ; |
s2_middle_1_right = $05D1 ; |
s2_middle_2_right = $05F1 ; +

s3_up_1_left      = $058E ; +
s3_up_2_left      = $058F ; |
s3_up_1_right     = $0590 ; |
s3_up_2_right     = $0591 ; |
s3_down_1_left    = $062E ; |
s3_down_2_left    = $062F ; |
s3_down_1_right   = $0630 ; |
s3_down_2_right   = $0631 ; |_third see square
s3_middle_1_left  = $05AD ; |
s3_middle_2_left  = $05CD ; |
s3_middle_3_left  = $05ED ; |
s3_middle_4_left  = $060D ; |
s3_middle_1_right = $05B2 ; |
s3_middle_2_right = $05D2 ; |
s3_middle_3_right = $05F2 ; |
s3_middle_4_right = $0612 ; +

s4_up_1_left      = $056D ; +
s4_up_2_left      = $056E ; |
s4_up_3_left      = $056F ; |
s4_up_1_right     = $0570 ; |
s4_up_2_right     = $0571 ; |
s4_up_3_right     = $0572 ; |
s4_down_1_left    = $064D ; |
s4_down_2_left    = $064E ; |
s4_down_3_left    = $064F ; |
s4_down_1_right   = $0650 ; |
s4_down_2_right   = $0651 ; |
s4_down_3_right   = $0652 ; |_fourth see square
s4_middle_1_left  = $058C ; |
s4_middle_2_left  = $05AC ; |
s4_middle_3_left  = $05CC ; |
s4_middle_4_left  = $05EC ; |
s4_middle_5_left  = $060C ; |
s4_middle_6_left  = $062C ; |
s4_middle_1_right = $0593 ; |
s4_middle_2_right = $05B3 ; |
s4_middle_3_right = $05D3 ; |
s4_middle_4_right = $05F3 ; |
s4_middle_5_right = $0613 ; |
s4_middle_6_right = $0633 ; +

s5_up_1_left      = $054C ; +
s5_up_2_left      = $054D ; |
s5_up_3_left      = $054E ; |
s5_up_4_left      = $054F ; |
s5_up_1_right     = $0550 ; |
s5_up_2_right     = $0551 ; |
s5_up_3_right     = $0552 ; |
s5_up_4_right     = $0553 ; |
s5_down_1_left    = $066C ; |
s5_down_2_left    = $066D ; |
s5_down_3_left    = $066E ; |
s5_down_4_left    = $066F ; |
s5_down_1_right   = $0670 ; |
s5_down_2_right   = $0671 ; |
s5_down_3_right   = $0672 ; |
s5_down_4_right   = $0673 ; |_fifth see square
s5_middle_1_left  = $056B ; |
s5_middle_2_left  = $058B ; |
s5_middle_3_left  = $05AB ; |
s5_middle_4_left  = $05CB ; |
s5_middle_5_left  = $05EB ; |
s5_middle_6_left  = $060B ; |
s5_middle_7_left  = $062B ; |
s5_middle_8_left  = $064B ; |
s5_middle_1_right = $0574 ; |
s5_middle_2_right = $0594 ; |
s5_middle_3_right = $05B4 ; |
s5_middle_4_right = $05D4 ; |
s5_middle_5_right = $05F4 ; |
s5_middle_6_right = $0614 ; |
s5_middle_7_right = $0634 ; |
s5_middle_8_right = $0654 ; +

s6_up_1_left      = $052B ; +
s6_up_2_left      = $052C ; |
s6_up_3_left      = $052D ; |
s6_up_4_left      = $052E ; |
s6_up_5_left      = $052F ; |
s6_up_1_right     = $0530 ; |
s6_up_2_right     = $0531 ; |
s6_up_3_right     = $0532 ; |
s6_up_4_right     = $0533 ; |
s6_up_5_right     = $0534 ; |
s6_down_1_left    = $068B ; |
s6_down_2_left    = $068C ; |
s6_down_3_left    = $068D ; |
s6_down_4_left    = $068E ; |
s6_down_5_left    = $068F ; |
s6_down_1_right   = $0690 ; |
s6_down_2_right   = $0691 ; |
s6_down_3_right   = $0692 ; |
s6_down_4_right   = $0693 ; |
s6_down_5_right   = $0694 ; |_sixth see square
s6_middle_1_left  = $054A ; |
s6_middle_2_left  = $056A ; |
s6_middle_3_left  = $058A ; |
s6_middle_4_left  = $05AA ; |
s6_middle_5_left  = $05CA ; |
s6_middle_6_left  = $05EA ; |
s6_middle_7_left  = $060A ; |
s6_middle_8_left  = $062A ; |
s6_middle_9_left  = $064A ; |
s6_middle_10_left = $066A ; |
s6_middle_1_right = $0555 ; |
s6_middle_2_right = $0575 ; |
s6_middle_3_right = $0595 ; |
s6_middle_4_right = $05B5 ; |
s6_middle_5_right = $05D5 ; |
s6_middle_6_right = $05F5 ; |
s6_middle_7_right = $0615 ; |
s6_middle_8_right = $0635 ; |
s6_middle_9_right = $0655 ; |
s6_middle_10_right= $0675 ; +

s7_up_1_left      = $050A ; +
s7_up_2_left      = $050B ; |
s7_up_3_left      = $050C ; |
s7_up_4_left      = $050D ; |
s7_up_5_left      = $050E ; |
s7_up_6_left      = $050F ; |
s7_up_1_right     = $0510 ; |
s7_up_2_right     = $0511 ; |
s7_up_3_right     = $0512 ; |
s7_up_4_right     = $0513 ; |
s7_up_5_right     = $0514 ; |
s7_up_6_right     = $0515 ; |
s7_down_1_left    = $06AA ; |
s7_down_2_left    = $06AB ; |
s7_down_3_left    = $06AC ; |
s7_down_4_left    = $06AD ; |
s7_down_5_left    = $06AE ; |
s7_down_6_left    = $06AF ; |
s7_down_1_right   = $06B0 ; |
s7_down_2_right   = $06B1 ; |
s7_down_3_right   = $06B2 ; |
s7_down_4_right   = $06B3 ; |
s7_down_5_right   = $06B4 ; |
s7_down_6_right   = $06B5 ; |_seventh see square
s7_middle_1_left  = $0529 ; |
s7_middle_2_left  = $0549 ; |
s7_middle_3_left  = $0569 ; |
s7_middle_4_left  = $0589 ; |
s7_middle_5_left  = $05A9 ; |
s7_middle_6_left  = $05C9 ; |
s7_middle_7_left  = $05E9 ; |
s7_middle_8_left  = $0609 ; |
s7_middle_9_left  = $0629 ; |
s7_middle_10_left = $0649 ; |
s7_middle_11_left = $0669 ; |
s7_middle_12_left = $0689 ; |
s7_middle_1_right = $0536 ; |
s7_middle_2_right = $0556 ; |
s7_middle_3_right = $0576 ; |
s7_middle_4_right = $0596 ; |
s7_middle_5_right = $05B6 ; |
s7_middle_6_right = $05D6 ; |
s7_middle_7_right = $05F6 ; |
s7_middle_8_right = $0616 ; |
s7_middle_9_right = $0636 ; |
s7_middle_10_right= $0656 ; |
s7_middle_11_right= $0676 ; |
s7_middle_12_right= $0696 ; +

s8_up_1_left      = $04E9 ; +
s8_up_2_left      = $04EA ; |
s8_up_3_left      = $04EB ; |
s8_up_4_left      = $04EC ; |
s8_up_5_left      = $04ED ; |
s8_up_6_left      = $04EE ; |
s8_up_7_left      = $04EF ; |
s8_up_1_right     = $04F0 ; |
s8_up_2_right     = $04F1 ; |
s8_up_3_right     = $04F2 ; |
s8_up_4_right     = $04F3 ; |
s8_up_5_right     = $04F4 ; |
s8_up_6_right     = $04F5 ; |
s8_up_7_right     = $04F6 ; |
s8_down_1_left    = $06C9 ; |
s8_down_2_left    = $06CA ; |
s8_down_3_left    = $06CB ; |
s8_down_4_left    = $06CC ; |
s8_down_5_left    = $06CD ; |
s8_down_6_left    = $06CE ; |
s8_down_7_left    = $06CF ; |
s8_down_1_right   = $06D0 ; |
s8_down_2_right   = $06D1 ; |
s8_down_3_right   = $06D2 ; |
s8_down_4_right   = $06D3 ; |
s8_down_5_right   = $06D4 ; |
s8_down_6_right   = $06D5 ; |
s8_down_7_right   = $06D6 ; |_eigth see square
s8_middle_1_left  = $0508 ; |
s8_middle_2_left  = $0528 ; |
s8_middle_3_left  = $0548 ; |
s8_middle_4_left  = $0568 ; |
s8_middle_5_left  = $0588 ; |
s8_middle_6_left  = $05A8 ; |
s8_middle_7_left  = $05C8 ; |
s8_middle_8_left  = $05E8 ; |
s8_middle_9_left  = $0608 ; |
s8_middle_10_left = $0628 ; |
s8_middle_11_left = $0648 ; |
s8_middle_12_left = $0668 ; |
s8_middle_13_left = $0688 ; |
s8_middle_14_left = $06A8 ; |
s8_middle_1_right = $0517 ; |
s8_middle_2_right = $0537 ; |
s8_middle_3_right = $0557 ; |
s8_middle_4_right = $0577 ; |
s8_middle_5_right = $0597 ; |
s8_middle_6_right = $05B7 ; |
s8_middle_7_right = $05D7 ; |
s8_middle_8_right = $05F7 ; |
s8_middle_9_right = $0617 ; |
s8_middle_10_right= $0637 ; |
s8_middle_11_right= $0657 ; |
s8_middle_12_right= $0677 ; |
s8_middle_13_right= $0697 ; |
s8_middle_14_right= $06B7 ; +

s9_up_1_left      = $04C8 ; +
s9_up_2_left      = $04C9 ; |
s9_up_3_left      = $04CA ; |
s9_up_4_left      = $04CB ; |
s9_up_5_left      = $04CC ; |
s9_up_6_left      = $04CD ; |
s9_up_7_left      = $04CE ; |
s9_up_8_left      = $04CF ; |
s9_up_1_right     = $04D0 ; |
s9_up_2_right     = $04D1 ; |
s9_up_3_right     = $04D2 ; |
s9_up_4_right     = $04D3 ; |
s9_up_5_right     = $04D4 ; |
s9_up_6_right     = $04D5 ; |
s9_up_7_right     = $04D6 ; |
s9_up_8_right     = $04D7 ; |
s9_down_1_left    = $06E8 ; |
s9_down_2_left    = $06E9 ; |
s9_down_3_left    = $06EA ; |
s9_down_4_left    = $06EB ; |
s9_down_5_left    = $06EC ; |
s9_down_6_left    = $06ED ; |
s9_down_7_left    = $06EE ; |
s9_down_8_left    = $06EF ; |
s9_down_1_right   = $06F0 ; |
s9_down_2_right   = $06F1 ; |
s9_down_3_right   = $06F2 ; |
s9_down_4_right   = $06F3 ; |
s9_down_5_right   = $06F4 ; |
s9_down_6_right   = $06F5 ; |
s9_down_7_right   = $06F6 ; |
s9_down_8_right   = $06F7 ; |_ninth see square
s9_middle_1_left  = $04E7 ; |
s9_middle_2_left  = $0507 ; |
s9_middle_3_left  = $0527 ; |
s9_middle_4_left  = $0547 ; |
s9_middle_5_left  = $0567 ; |
s9_middle_6_left  = $0587 ; |
s9_middle_7_left  = $05A7 ; |
s9_middle_8_left  = $05C7 ; |
s9_middle_9_left  = $05E7 ; |
s9_middle_10_left = $0607 ; |
s9_middle_11_left = $0627 ; |
s9_middle_12_left = $0647 ; |
s9_middle_13_left = $0667 ; |
s9_middle_14_left = $0687 ; |
s9_middle_15_left = $06A7 ; |
s9_middle_16_left = $06E7 ; |
s9_middle_1_right = $04F8 ; |
s9_middle_2_right = $0518 ; |
s9_middle_3_right = $0538 ; |
s9_middle_4_right = $0558 ; |
s9_middle_5_right = $0578 ; |
s9_middle_6_right = $0598 ; |
s9_middle_7_right = $05B8 ; |
s9_middle_8_right = $05D8 ; |
s9_middle_9_right = $05F8 ; |
s9_middle_10_right= $0618 ; |
s9_middle_11_right= $0638 ; |
s9_middle_12_right= $0658 ; |
s9_middle_13_right= $0678 ; |
s9_middle_14_right= $0698 ; |
s9_middle_15_right= $06B8 ; |
s9_middle_16_right= $06D8 ; +

sA_up_1_left      = $04A7 ; +
sA_up_2_left      = $04A8 ; |
sA_up_3_left      = $04A9 ; |
sA_up_4_left      = $04AA ; |
sA_up_5_left      = $04AB ; |
sA_up_6_left      = $04AC ; |
sA_up_7_left      = $04AD ; |
sA_up_8_left      = $04AE ; |
sA_up_9_left      = $04AF ; |
sA_up_1_right     = $04B0 ; |
sA_up_2_right     = $04B1 ; |
sA_up_3_right     = $04B2 ; |
sA_up_4_right     = $04B3 ; |
sA_up_5_right     = $04B4 ; |
sA_up_6_right     = $04B5 ; |
sA_up_7_right     = $04B6 ; |
sA_up_8_right     = $04B7 ; |
sA_up_9_right     = $04B8 ; |
sA_down_1_left    = $0707 ; |
sA_down_2_left    = $0708 ; |
sA_down_3_left    = $0709 ; |
sA_down_4_left    = $070A ; |
sA_down_5_left    = $070B ; |
sA_down_6_left    = $070C ; |
sA_down_7_left    = $070D ; |
sA_down_8_left    = $070E ; |
sA_down_9_left    = $070F ; |
sA_down_1_right   = $0710 ; |
sA_down_2_right   = $0711 ; |
sA_down_3_right   = $0712 ; |
sA_down_4_right   = $0713 ; |
sA_down_5_right   = $0714 ; |
sA_down_6_right   = $0715 ; |
sA_down_7_right   = $0716 ; |
sA_down_8_right   = $0717 ; |
sA_down_9_right   = $0718 ; |_tenth see square
sA_middle_1_left  = $04C6 ; |
sA_middle_2_left  = $04E6 ; |
sA_middle_3_left  = $0506 ; |
sA_middle_4_left  = $0526 ; |
sA_middle_5_left  = $0546 ; |
sA_middle_6_left  = $0566 ; |
sA_middle_7_left  = $0586 ; |
sA_middle_8_left  = $05A6 ; |
sA_middle_9_left  = $05C6 ; |
sA_middle_10_left = $05E6 ; |
sA_middle_11_left = $0606 ; |
sA_middle_12_left = $0626 ; |
sA_middle_13_left = $0646 ; |
sA_middle_14_left = $0666 ; |
sA_middle_15_left = $0686 ; |
sA_middle_16_left = $06A6 ; |
sA_middle_17_left = $06C6 ; |
sA_middle_18_left = $06E6 ; |
sA_middle_1_right = $04D9 ; |
sA_middle_2_right = $04F9 ; |
sA_middle_3_right = $0519 ; |
sA_middle_4_right = $0539 ; |
sA_middle_5_right = $0559 ; |
sA_middle_6_right = $0579 ; |
sA_middle_7_right = $0599 ; |
sA_middle_8_right = $05B9 ; |
sA_middle_9_right = $05D9 ; |
sA_middle_10_right= $05F9 ; |
sA_middle_11_right= $0619 ; |
sA_middle_12_right= $0639 ; |
sA_middle_13_right= $0659 ; |
sA_middle_14_right= $0679 ; |
sA_middle_15_right= $0699 ; |
sA_middle_16_right= $06B9 ; |
sA_middle_17_right= $06D9 ; |
sA_middle_18_right= $06F9 ; +

sB_up_1_left      = $0486 ; +
sB_up_2_left      = $0487 ; |
sB_up_3_left      = $0488 ; |
sB_up_4_left      = $0489 ; |
sB_up_5_left      = $048A ; |
sB_up_6_left      = $048B ; |
sB_up_7_left      = $048C ; |
sB_up_8_left      = $048D ; |
sB_up_9_left      = $048E ; |
sB_up_10_left     = $048F ; |
sB_up_1_right     = $0490 ; |
sB_up_2_right     = $0491 ; |
sB_up_3_right     = $0492 ; |
sB_up_4_right     = $0493 ; |
sB_up_5_right     = $0494 ; |
sB_up_6_right     = $0495 ; |
sB_up_7_right     = $0496 ; |
sB_up_8_right     = $0497 ; |
sB_up_9_right     = $0498 ; |
sB_up_10_right    = $0499 ; |
sB_down_1_left    = $0726 ; |
sB_down_2_left    = $0727 ; |
sB_down_3_left    = $0728 ; |
sB_down_4_left    = $0729 ; |
sB_down_5_left    = $072A ; |
sB_down_6_left    = $072B ; |
sB_down_7_left    = $072C ; |
sB_down_8_left    = $072D ; |
sB_down_9_left    = $072E ; |
sB_down_10_left   = $072F ; |
sB_down_1_right   = $0730 ; |
sB_down_2_right   = $0731 ; |
sB_down_3_right   = $0732 ; |
sB_down_4_right   = $0733 ; |
sB_down_5_right   = $0734 ; |
sB_down_6_right   = $0735 ; |
sB_down_7_right   = $0736 ; |
sB_down_8_right   = $0737 ; |
sB_down_9_right   = $0738 ; |
sB_down_10_right  = $0739 ; |_eleventh see square
sB_middle_1_left  = $04A5 ; |
sB_middle_2_left  = $04C5 ; |
sB_middle_3_left  = $04E5 ; |
sB_middle_4_left  = $0505 ; |
sB_middle_5_left  = $0525 ; |
sB_middle_6_left  = $0545 ; |
sB_middle_7_left  = $0565 ; |
sB_middle_8_left  = $0585 ; |
sB_middle_9_left  = $05A5 ; |
sB_middle_10_left = $05C5 ; |
sB_middle_11_left = $05E5 ; |
sB_middle_12_left = $0605 ; |
sB_middle_13_left = $0625 ; |
sB_middle_14_left = $0645 ; |
sB_middle_15_left = $0665 ; |
sB_middle_16_left = $0685 ; |
sB_middle_17_left = $06A5 ; |
sB_middle_18_left = $06C5 ; |
sB_middle_19_left = $06E5 ; |
sB_middle_20_left = $0705 ; |
sB_middle_1_right = $04BA ; |
sB_middle_2_right = $04DA ; |
sB_middle_3_right = $04FA ; |
sB_middle_4_right = $051A ; |
sB_middle_5_right = $053A ; |
sB_middle_6_right = $055A ; |
sB_middle_7_right = $057A ; |
sB_middle_8_right = $059A ; |
sB_middle_9_right = $05BA ; |
sB_middle_10_right= $05DA ; |
sB_middle_11_right= $05FA ; |
sB_middle_12_right= $061A ; |
sB_middle_13_right= $063A ; |
sB_middle_14_right= $065A ; |
sB_middle_15_right= $067A ; |
sB_middle_16_right= $069A ; |
sB_middle_17_right= $06BA ; |
sB_middle_18_right= $06DA ; |
sB_middle_19_right= $06FA ; |
sB_middle_20_right= $071A ; +

sC_up_1_left      = $0465 ; +
sC_up_2_left      = $0466 ; |
sC_up_3_left      = $0467 ; |
sC_up_4_left      = $0468 ; |
sC_up_5_left      = $0469 ; |
sC_up_6_left      = $046A ; |
sC_up_7_left      = $046B ; |
sC_up_8_left      = $046C ; |
sC_up_9_left      = $046D ; |
sC_up_10_left     = $046E ; |
sC_up_11_left     = $046F ; |
sC_up_1_right     = $0470 ; |
sC_up_2_right     = $0471 ; |
sC_up_3_right     = $0472 ; |
sC_up_4_right     = $0473 ; |
sC_up_5_right     = $0474 ; |
sC_up_6_right     = $0475 ; |
sC_up_7_right     = $0476 ; |
sC_up_8_right     = $0477 ; |
sC_up_9_right     = $0478 ; |
sC_up_10_right    = $0479 ; |
sC_up_11_right    = $047A ; |
sC_down_1_left    = $0745 ; |
sC_down_2_left    = $0746 ; |
sC_down_3_left    = $0747 ; |
sC_down_4_left    = $0748 ; |
sC_down_5_left    = $0749 ; |
sC_down_6_left    = $074A ; |
sC_down_7_left    = $074B ; |
sC_down_8_left    = $074C ; |
sC_down_9_left    = $074D ; |
sC_down_10_left   = $074E ; |
sC_down_11_left   = $074F ; |
sC_down_1_right   = $0750 ; |
sC_down_2_right   = $0751 ; |
sC_down_3_right   = $0752 ; |
sC_down_4_right   = $0753 ; |
sC_down_5_right   = $0754 ; |
sC_down_6_right   = $0755 ; |
sC_down_7_right   = $0756 ; |
sC_down_8_right   = $0757 ; |
sC_down_9_right   = $0758 ; |
sC_down_10_right  = $0759 ; |
sC_down_11_right  = $075A ; |_twelveth see square
sC_middle_1_left  = $0484 ; |
sC_middle_2_left  = $04A4 ; |
sC_middle_3_left  = $04C4 ; |
sC_middle_4_left  = $04E4 ; |
sC_middle_5_left  = $0504 ; |
sC_middle_6_left  = $0524 ; |
sC_middle_7_left  = $0544 ; |
sC_middle_8_left  = $0564 ; |
sC_middle_9_left  = $0584 ; |
sC_middle_10_left = $05A4 ; |
sC_middle_11_left = $05C4 ; |
sC_middle_12_left = $05E4 ; |
sC_middle_13_left = $0604 ; |
sC_middle_14_left = $0624 ; |
sC_middle_15_left = $0644 ; |
sC_middle_16_left = $0664 ; |
sC_middle_17_left = $0684 ; |
sC_middle_18_left = $06A4 ; |
sC_middle_19_left = $06C4 ; |
sC_middle_20_left = $06E4 ; |
sC_middle_21_left = $0704 ; |
sC_middle_22_left = $0724 ; |
sC_middle_1_right = $049B ; |
sC_middle_2_right = $04BB ; |
sC_middle_3_right = $04DB ; |
sC_middle_4_right = $04FB ; |
sC_middle_5_right = $051B ; |
sC_middle_6_right = $053B ; |
sC_middle_7_right = $055B ; |
sC_middle_8_right = $057B ; |
sC_middle_9_right = $059B ; |
sC_middle_10_right= $05BB ; |
sC_middle_11_right= $05DB ; |
sC_middle_12_right= $05FB ; |
sC_middle_13_right= $061B ; |
sC_middle_14_right= $063B ; |
sC_middle_15_right= $065B ; |
sC_middle_16_right= $067B ; |
sC_middle_17_right= $069B ; |
sC_middle_18_right= $06BB ; |
sC_middle_19_right= $06DB ; |
sC_middle_20_right= $06FB ; |
sC_middle_21_right= $071B ; |
sC_middle_22_right= $073B ; +

sD_up_1_left      = $0444 ; +
sD_up_2_left      = $0445 ; |
sD_up_3_left      = $0446 ; |
sD_up_4_left      = $0447 ; |
sD_up_5_left      = $0448 ; |
sD_up_6_left      = $0449 ; |
sD_up_7_left      = $044A ; |
sD_up_8_left      = $044B ; |
sD_up_9_left      = $044C ; |
sD_up_10_left     = $044D ; |
sD_up_11_left     = $044E ; |
sD_up_12_left     = $044F ; |
sD_up_1_right     = $0450 ; |
sD_up_2_right     = $0451 ; |
sD_up_3_right     = $0452 ; |
sD_up_4_right     = $0453 ; |
sD_up_5_right     = $0454 ; |
sD_up_6_right     = $0455 ; |
sD_up_7_right     = $0456 ; |
sD_up_8_right     = $0457 ; |
sD_up_9_right     = $0458 ; |
sD_up_10_right    = $0459 ; |
sD_up_11_right    = $045A ; |
sD_up_12_right    = $045B ; |
sD_down_1_left    = $0764 ; |
sD_down_2_left    = $0765 ; |
sD_down_3_left    = $0766 ; |
sD_down_4_left    = $0767 ; |
sD_down_5_left    = $0768 ; |
sD_down_6_left    = $0769 ; |
sD_down_7_left    = $076A ; |
sD_down_8_left    = $076B ; |
sD_down_9_left    = $076C ; |
sD_down_10_left   = $076D ; |
sD_down_11_left   = $076E ; |
sD_down_12_left   = $076F ; |
sD_down_1_right   = $0770 ; |
sD_down_2_right   = $0771 ; |
sD_down_3_right   = $0772 ; |
sD_down_4_right   = $0773 ; |
sD_down_5_right   = $0774 ; |
sD_down_6_right   = $0775 ; |
sD_down_7_right   = $0776 ; |
sD_down_8_right   = $0777 ; |
sD_down_9_right   = $0778 ; |
sD_down_10_right  = $0779 ; |
sD_down_11_right  = $077A ; |
sD_down_12_right  = $077B ; |_thirteenth see square
sD_middle_1_left  = $0463 ; |
sD_middle_2_left  = $0483 ; |
sD_middle_3_left  = $04A3 ; |
sD_middle_4_left  = $04C3 ; |
sD_middle_5_left  = $04E3 ; |
sD_middle_6_left  = $0503 ; |
sD_middle_7_left  = $0523 ; |
sD_middle_8_left  = $0543 ; |
sD_middle_9_left  = $0563 ; |
sD_middle_10_left = $0583 ; |
sD_middle_11_left = $05A3 ; |
sD_middle_12_left = $05C3 ; |
sD_middle_13_left = $05E3 ; |
sD_middle_14_left = $0603 ; |
sD_middle_15_left = $0623 ; |
sD_middle_16_left = $0643 ; |
sD_middle_17_left = $0663 ; |
sD_middle_18_left = $0683 ; |
sD_middle_19_left = $06A3 ; |
sD_middle_20_left = $06C3 ; |
sD_middle_21_left = $06E3 ; |
sD_middle_22_left = $0703 ; |
sD_middle_23_left = $0723 ; |
sD_middle_24_left = $0743 ; |
sD_middle_1_right = $047C ; |
sD_middle_2_right = $049C ; |
sD_middle_3_right = $04BC ; |
sD_middle_4_right = $04DC ; |
sD_middle_5_right = $04FC ; |
sD_middle_6_right = $051C ; |
sD_middle_7_right = $053C ; |
sD_middle_8_right = $055C ; |
sD_middle_9_right = $057C ; |
sD_middle_10_right= $059C ; |
sD_middle_11_right= $05BC ; |
sD_middle_12_right= $05DC ; |
sD_middle_13_right= $05FC ; |
sD_middle_14_right= $061C ; |
sD_middle_15_right= $063C ; |
sD_middle_16_right= $065C ; |
sD_middle_17_right= $067C ; |
sD_middle_18_right= $069C ; |
sD_middle_19_right= $06BC ; |
sD_middle_20_right= $06DC ; |
sD_middle_21_right= $06FC ; |
sD_middle_22_right= $071C ; |
sD_middle_23_right= $073C ; |
sD_middle_24_right= $075C ; +

sE_up_1_left      = $0423 ; +
sE_up_2_left      = $0424 ; |
sE_up_3_left      = $0425 ; |
sE_up_4_left      = $0426 ; |
sE_up_5_left      = $0427 ; |
sE_up_6_left      = $0428 ; |
sE_up_7_left      = $0429 ; |
sE_up_8_left      = $042A ; |
sE_up_9_left      = $042B ; |
sE_up_10_left     = $042C ; |
sE_up_11_left     = $042D ; |
sE_up_12_left     = $042E ; |
sE_up_13_left     = $042F ; |
sE_up_1_right     = $0430 ; |
sE_up_2_right     = $0431 ; |
sE_up_3_right     = $0432 ; |
sE_up_4_right     = $0433 ; |
sE_up_5_right     = $0434 ; |
sE_up_6_right     = $0435 ; |
sE_up_7_right     = $0436 ; |
sE_up_8_right     = $0437 ; |
sE_up_9_right     = $0438 ; |
sE_up_10_right    = $0439 ; |
sE_up_11_right    = $043A ; |
sE_up_12_right    = $043B ; |
sE_up_13_right    = $043C ; |
sE_down_1_left    = $0783 ; |
sE_down_2_left    = $0784 ; |
sE_down_3_left    = $0785 ; |
sE_down_4_left    = $0786 ; |
sE_down_5_left    = $0787 ; |
sE_down_6_left    = $0788 ; |
sE_down_7_left    = $0789 ; |
sE_down_8_left    = $078A ; |
sE_down_9_left    = $078B ; |
sE_down_10_left   = $078C ; |
sE_down_11_left   = $078D ; |
sE_down_12_left   = $078E ; |
sE_down_13_left   = $078F ; |
sE_down_1_right   = $0790 ; |
sE_down_2_right   = $0791 ; |
sE_down_3_right   = $0792 ; |
sE_down_4_right   = $0793 ; |
sE_down_5_right   = $0794 ; |
sE_down_6_right   = $0795 ; |
sE_down_7_right   = $0796 ; |
sE_down_8_right   = $0797 ; |
sE_down_9_right   = $0798 ; |
sE_down_10_right  = $0799 ; |
sE_down_11_right  = $079A ; |
sE_down_12_right  = $079B ; |
sE_down_13_right  = $079C ; |_fourteenth see square
sE_middle_1_left  = $0442 ; |
sE_middle_2_left  = $0462 ; |
sE_middle_3_left  = $0482 ; |
sE_middle_4_left  = $04A2 ; |
sE_middle_5_left  = $04C2 ; |
sE_middle_6_left  = $04E2 ; |
sE_middle_7_left  = $0502 ; |
sE_middle_8_left  = $0522 ; |
sE_middle_9_left  = $0542 ; |
sE_middle_10_left = $0562 ; |
sE_middle_11_left = $0582 ; |
sE_middle_12_left = $05A2 ; |
sE_middle_13_left = $05C2 ; |
sE_middle_14_left = $05E2 ; |
sE_middle_15_left = $0602 ; |
sE_middle_16_left = $0622 ; |
sE_middle_17_left = $0642 ; |
sE_middle_18_left = $0662 ; |
sE_middle_19_left = $0682 ; |
sE_middle_20_left = $06A2 ; |
sE_middle_21_left = $06C2 ; |
sE_middle_22_left = $06E2 ; |
sE_middle_23_left = $0702 ; |
sE_middle_24_left = $0722 ; |
sE_middle_25_left = $0742 ; |
sE_middle_26_left = $0762 ; |
sE_middle_1_right = $045D ; |
sE_middle_2_right = $047D ; |
sE_middle_3_right = $049D ; |
sE_middle_4_right = $04BD ; |
sE_middle_5_right = $04DD ; |
sE_middle_6_right = $04FD ; |
sE_middle_7_right = $051D ; |
sE_middle_8_right = $053D ; |
sE_middle_9_right = $055D ; |
sE_middle_10_right= $057D ; |
sE_middle_11_right= $059D ; |
sE_middle_12_right= $05BD ; |
sE_middle_13_right= $05DD ; |
sE_middle_14_right= $05FD ; |
sE_middle_15_right= $061D ; |
sE_middle_16_right= $063D ; |
sE_middle_17_right= $065D ; |
sE_middle_18_right= $067D ; |
sE_middle_19_right= $069D ; |
sE_middle_20_right= $06BD ; |
sE_middle_21_right= $06DD ; |
sE_middle_22_right= $06FD ; |
sE_middle_23_right= $071D ; |
sE_middle_24_right= $073D ; |
sE_middle_25_right= $075D ; |
sE_middle_26_right= $077D ; +

corner_down_left_1  = $0782
corner_down_left_2  = $0763
corner_down_left_3  = $0744
corner_down_left_4  = $0725
corner_down_left_5  = $0706
corner_down_left_6  = $06E7
corner_down_left_7  = $06C8
corner_down_left_8  = $06A9
corner_down_left_9  = $068A
corner_down_left_10 = $066B
corner_down_left_11 = $064C
corner_down_left_12 = $062D
corner_down_left_13 = $060E

corner_down_right_1  = $079D
corner_down_right_2  = $077C
corner_down_right_3  = $075B
corner_down_right_4  = $073A
corner_down_right_5  = $0719
corner_down_right_6  = $06F8
corner_down_right_7  = $06D7
corner_down_right_8  = $06B6
corner_down_right_9  = $0695
corner_down_right_10 = $0674
corner_down_right_11 = $0653
corner_down_right_12 = $0632
corner_down_right_13 = $0611


;variable
pointerLo: .res 1   ; pointer variables are declared in RAM
pointerHi:  .res 1   ; low byte first, high byte immediately after
buttonsInstant: .res 1
buttonsPressed: .res 1
scrolly: .res 1
direction: .res 1    ; [0000|E|S|W|N]
tempnybble: .res 1
timer: .res 1
backgroundID: .res 1
j: .res 1
indexByte: .res 1
rayLength: .res 1
waitingForUpdate: .res 1

.SEGMENT "STARTUP"

RESET:
  .INCLUDE "init.asm"

.SEGMENT "CODE"

  LDA #$04
  STA direction
  LDA #$40
  STA j
  LDA #$04
  STA indexByte

  LDA #$01
  STA backgroundID
  STA waitingForUpdate
  LDA #$0E
  STA rayLength

  JSR LoadPalette
  

  LDA #%10010000
  STA PPU_CTRL
  LDA #%00011110
  STA PPU_MASK

  JSR writeMaze
  JSR LoadDirectionSprite

mainloop:
  LDA waitingForUpdate
  BEQ @forever
  LDA #$00
  STA PPU_CTRL
  STA PPU_MASK

  JSR refreshBGBank
  JSR updateBGdrawingHallwayEnd
  JSR LoadDirectionSprite

  LDA #$00
  STA pointerLo
  LDA #$04
  STA pointerHi
  JSR LoadBackground
  DEC waitingForUpdate
  LDA #$80
  STA PPU_CTRL
  @forever:
  JMP mainloop

NMI:
  LDA #$00
  STA PPU_OAM_ADDR
  LDA #$02
  STA OAM_DMA

  LDA #%10010000
  STA PPU_CTRL
  LDA #%00011110
  STA PPU_MASK
  LDA #$00
  STA PPU_SCROLL
  LDA scrolly
  STA PPU_SCROLL
  JSR ReadController1  ;;get the current button data for player 1
  JSR checkForPressedBtn
  

ReadUp:
  LDA buttonsInstant
  AND #$08
  BEQ ReadDown             ; if 0 the player didn't press up
  LDA direction
  AND #$0E                 ; if this bitmask operation leave a bit the direction is not north
  BNE @notNorth
  @decrementIndex:
  LDA indexByte            ; else we decrement in the bitmap
  SEC
  SBC #$04
  BMI @end
  STA indexByte
  JSR getJposition
  BEQ @end                 ; A == 0 then no collision
  BVC @incrementIndex      ; else collision revert the action
  @notNorth:
  AND #$0C
  BNE @notWest             ; if this bitmask operation leave a bit the direction is not west
  @incrementJ:
  LDA j
  CMP #$80
  CLC
  BNE @justRotate          ; if the bit is at the last west location 
  LDA indexByte
  SEC
  SBC #$01
  BMI @end
  STA indexByte
  LDA j
  SEC
  @justRotate:
  ROL
  STA j
  JSR getJposition
  BEQ @end                 ; no colli
  BVC @decrementJ
  @notWest:
  AND #$08
  BNE @notSouth            ; if this bitmask operation leave a bit the direction is not South it's East
  @incrementIndex:
  LDA indexByte
  CLC
  ADC #$04
  CMP #$40
  BCS @end
  STA indexByte
  JSR getJposition
  BEQ @end                 ; A == 0 then no collision
  BVC @decrementIndex      ; else collision revert the action
  @notSouth:
  @decrementJ:
  LDA j
  CMP #$01
  CLC
  BNE @justRor              ; if the bit is at the last east location 
  LDA indexByte
  CLC
  ADC #$01
  CMP #$40
  BCS @end
  STA indexByte
  LDA j
  SEC
  @justRor:
  ROR
  STA j
  JSR getJposition
  BEQ @end                  ; no coli
  BVC @incrementJ
  @end:
  JMP ReadDone

ReadDown:
  LDA buttonsInstant
  AND #$04
  BEQ ReadLeft
  LDA direction
  AND #$0E                 ; if this bitmask operation leave a bit the direction is not north
  BNE @notNorth
  @incrementIndex:
  LDA indexByte
  CLC
  ADC #$04
  CMP #$40
  BCS @end
  STA indexByte
  JSR getJposition
  BEQ @end                 ; A == 0 then no collision
  BVC @decrementIndex      ; else collision revert the action
  @notNorth:
  AND #$0C
  BNE @notWest             ; if this bitmask operation leave a bit the direction is not west
  @decrementJ:
  LDA j
  CMP #$01
  CLC
  BNE @justRor              ; if the bit is at the last east location 
  LDA indexByte
  CLC
  ADC #$01
  CMP #$40
  BCS @end
  STA indexByte
  LDA j
  SEC
  @justRor:
  ROR
  STA j
  JSR getJposition
  BEQ @end                 ; no coli
  BVC @incrementJ
  @notWest:
  AND #$08
  BNE @notSouth            ; if this bitmask operation leave a bit the direction is not South it's East
  @decrementIndex:
  LDA indexByte
  SEC
  SBC #$04
  BMI @end
  STA indexByte
  JSR getJposition
  BEQ @end                 ; A == 0 then no collision
  BVC @incrementIndex      ; else collision revert the action
  @notSouth:
  @incrementJ:
  LDA j
  CMP #$80
  CLC
  BNE @justRotate          ; if the bit is at the last west location 
  LDA indexByte
  SEC
  SBC #$01
  BMI @end
  STA indexByte
  LDA j
  SEC
  @justRotate:
  ROL
  STA j
  JSR getJposition
  BEQ @end                 ; no colli
  BVC @decrementJ
  @end:
  JMP ReadDone

ReadLeft:
  LDA buttonsInstant
  AND #$02
  BEQ ReadRight
  LDA direction
  AND #$F0
  STA tempnybble
  LDA direction
  AND #$0F
  CMP #$08
  BCS leNordShift
  ASL A
  ORA tempnybble
  STA direction
  JMP doneShiftLeft
leNordShift:
  LDA #$01
  ORA tempnybble
  STA direction
doneShiftLeft:
  JMP ReadDone

ReadRight:
  LDA buttonsInstant
  AND #$01
  BEQ ReadDone
  LDA direction
  AND #$F0
  STA tempnybble
  LDA direction
  AND #$0F
  CMP #$02
  BCC leSudShift
  LSR A
  ORA tempnybble
  STA direction
  JMP doneShiftRight
leSudShift:
  LDA #$08
  ORA tempnybble
  STA direction
doneShiftRight:

ReadDone:
  JSR decreasetimer
  JSR findCorridorLength
  LDA buttonsInstant    ; did a read occur, meaning change in state
  BEQ @noRead
  INC waitingForUpdate
  @noRead:

  RTI


VBlankWait:
  BIT PPU_STATUS
  BPL VBlankWait
  RTS

break:
  LDA #$00
  STA scrolly
  RTS

decreasetimer:
  LDX timer
  BEQ ExitTimer
  DEX
  STX timer
ExitTimer:
  RTS

LoadPalette:
  LDA #$3F
  STA PPU_ADDRESS
  LDA #$00
  STA PPU_ADDRESS
  LDX #$00
LoadPaletteLoop:
  LDA paletteData,x
  STA PPU_DATA
  INX
  CPX #$20
  BNE LoadPaletteLoop
  RTS


ReadController1:
  LDA #$01
  STA JOY1
  LDA #$00
  STA JOY1
  LDX #$08
ReadController1Loop:
  LDA JOY1
  LSR A
  ROL buttonsInstant
  DEX
  BNE ReadController1Loop
  RTS

checkForPressedBtn:
  LDA buttonsInstant
  TAY
  EOR buttonsPressed
  AND buttonsInstant
  STY buttonsPressed
  STA buttonsInstant
  RTS


LoadBackground:
  LDA PPU_STATUS        ; read PPU status to reset the high/low latch
  LDA #$20
  STA PPU_ADDRESS       ; write the high byte of $2000 address
  LDA #$00
  STA PPU_ADDRESS       ; write the low byte of $2000 address
  
  LDX #$00              ; start at pointer + 0
  LDY #$00
OutsideLoop:
  
InsideLoop:
  LDA (pointerLo), y  ; copy one background byte from address in pointer plus Y
  STA PPU_DATA        ; this runs 256 * 4 times
  
  INY                 ; inside loop counter
  CPY #$00
  BNE InsideLoop      ; run the inside loop 256 times before continuing down
  
  INC pointerHi       ; low byte went 0 to 256, so high byte needs to be changed now
  
  INX
  CPX #$04
  BNE OutsideLoop     ; run the outside loop 256 times before continuing down
  RTS

writeMaze:
  LDX #$00
  @loop:
  LDA Maze,X
  STA $0300,X
  INX
  CPX #(MAZEWIDTH*MAZEHEIGHT)
  BNE @loop
  RTS

getJposition:            ; return a bool A = 0 if false and A = 1 if true (NOcollision/Collision)
  LDX indexByte
  LDA $0300,X
  JSR getNBbit
  STY tempnybble
  EOR j
  JSR getNBbit
  CPY tempnybble
  BCS @noCollision
  LDA #$01
  RTS
  @noCollision:
  LDA #$00
  RTS

getNBbit:             ; check in A how many bit we have and put that number in Y
  LDX #$00
  LDY #$00
  PHA
  CLC
  @nextbit:
  CPX #$08
  BEQ @endLoop
  ROR 
  INX
  BCC @nextbit
  INY
  BVC @nextbit
  @endLoop:
  PLA
  RTS

findCorridorLength:
  LDA #$00
  STA rayLength
  LDA direction
  AND #$0E                 ; if this bitmask operation leave a bit the direction is not north
  BNE @notNorth
  LDX indexByte
  @checkNextSquareNorth:
  DEX
  DEX
  DEX
  DEX
  INC rayLength
  LDA $0300,X
  AND j
  BEQ @checkNextSquareNorth
  JMP @end
  @notNorth:
  AND #$0C
  BNE @notWest
  LDX indexByte
  @checkNextSquareWest:
  LDA $0300,X
  LDY j
  @checkFirstByteWest:
  LSR
  STA tempnybble
  AND j
  BEQ @continueWestCheck
  INC rayLength
  JMP @end
  @continueWestCheck:
  CPY #$80
  BEQ @doneFirstByteWest
  INC rayLength
  TYA
  ASL
  TAY
  LDA tempnybble
  CPY #$80
  BNE @checkFirstByteWest
  @doneFirstByteWest:
  LDA #$03
  STA tempnybble
  @checkAdjacentByteWest:
  DEX
  LDA $0300,X
  LDY #$08
  INC rayLength
  STA timer
  AND #$01
  BEQ @continueAdjacentWestCheck
  JMP @end
  @continueAdjacentWestCheck:
  LDA timer
  DEY
  @loopWest:
  LSR
  INC rayLength
  STA timer
  AND #$01
  BNE @end
  LDA timer
  DEY
  BNE @loopWest
  LDA tempnybble
  SEC
  SBC #$01
  BEQ @end
  STA tempnybble
  BNE @checkAdjacentByteWest
  @notWest:
  AND #$08
  BNE @notSouth
  LDX indexByte
  @checkNextSquareSouth:
  INX
  INX
  INX
  INX
  INC rayLength
  LDA $0300,X
  AND j
  BEQ @checkNextSquareSouth
  JMP @end
  @notSouth:
  LDX indexByte
  @checkNextSquareEast:
  LDA $0300,X
  LDY j
  @checkFirstByteEast:
  ASL
  STA tempnybble
  AND j
  BEQ @continueEastCheck
  INC rayLength
  JMP @end
  @continueEastCheck:
  CPY #$01
  BEQ @doneFirstByteEast
  INC rayLength
  TYA
  LSR
  TAY
  LDA tempnybble
  CPY #$01
  BNE @checkFirstByteEast
  @doneFirstByteEast:
  LDA #$03
  STA tempnybble
  @checkAdjacentByte:
  INX
  LDA $0300,X
  LDY #$08
  INC rayLength
  STA timer
  AND #$80
  BNE @end
  LDA timer
  DEY
  @loopEast:
  ASL
  INC rayLength
  STA timer
  AND #$80
  BNE @end
  LDA timer
  DEY
  BNE @loopEast
  LDA tempnybble
  SEC
  SBC #$01
  BEQ @end
  STA tempnybble
  BNE @checkAdjacentByte
  @end:
  RTS
  

refreshBGBank:
  LDX #$00
  LDA #$24
  @loop:
  STA $0400,X
  STA $0500,X
  STA $0600,X
  STA $0700,X
  INX
  BNE @loop
  @writeAttr:
  LDA #$00
  STA $07C0,X
  INX
  CPX #$40
  BNE @writeAttr
  RTS

updateBGdrawingHallwayEnd:
  LDA rayLength
  CMP #$1F
  BCS @biggerthan30
  JMP @notbiggerthan30
  @biggerthan30:

  LDA #$38
  STA middle_corner_up_left
  LDA #$39
  STA middle_corner_up_right
  LDA #$39
  STA middle_corner_down_left
  LDA #$38
  STA middle_corner_down_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  STA corner_up_left_13
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  STA corner_up_right_13
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  STA corner_down_left_13
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12
  STA corner_down_right_13

  JMP @end
  @notbiggerthan30:
  CMP #$1E
  BCS @biggerthan29
  JMP @notbiggerthan29
  @biggerthan29:

  LDA #$61
  STA middle_corner_up_left
  LDA #$62
  STA middle_corner_up_right
  LDA #$63
  STA middle_corner_down_left
  LDA #$64
  STA middle_corner_down_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  STA corner_up_left_13
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  STA corner_up_right_13
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  STA corner_down_left_13
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12
  STA corner_down_right_13

  JMP @end
  @notbiggerthan29:
  CMP #$1D
  BCS @biggerthan28
  JMP @notbiggerthan28
  @biggerthan28:

  LDA #$5D
  STA middle_corner_up_left
  LDA #$5E
  STA middle_corner_up_right
  LDA #$5F
  STA middle_corner_down_left
  LDA #$60
  STA middle_corner_down_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  STA corner_up_left_13
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  STA corner_up_right_13
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  STA corner_down_left_13
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12
  STA corner_down_right_13

  JMP @end
  @notbiggerthan28:
  CMP #$1C
  BCS @biggerthan27
  JMP @notbiggerthan27
  @biggerthan27:

  LDA #$65
  STA middle_corner_up_left
  LDA #$66
  STA middle_corner_up_right
  LDA #$67
  STA middle_corner_down_left
  LDA #$68
  STA middle_corner_down_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  STA corner_up_left_13
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  STA corner_up_right_13
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  STA corner_down_left_13
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12
  STA corner_down_right_13

  JMP @end
  @notbiggerthan27:
  CMP #$1B
  BCS @biggerthan26
  JMP @notbiggerthan26
  @biggerthan26:

  LDA #$69
  STA middle_corner_up_left
  LDA #$6A
  STA middle_corner_up_right
  LDA #$6B
  STA middle_corner_down_left
  LDA #$6C
  STA middle_corner_down_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  STA corner_up_left_13
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  STA corner_up_right_13
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  STA corner_down_left_13
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12
  STA corner_down_right_13

  JMP @end
  @notbiggerthan26:
  CMP #$1A
  BCS @biggerthan25
  JMP @notbiggerthan25
  @biggerthan25:

  LDA #$6D
  STA middle_corner_up_left
  LDA #$6E
  STA middle_corner_up_right
  LDA #$6F
  STA middle_corner_down_left
  LDA #$70
  STA middle_corner_down_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  STA corner_up_left_13
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  STA corner_up_right_13
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  STA corner_down_left_13
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12
  STA corner_down_right_13

  JMP @end
  @notbiggerthan25:
  CMP #$19
  BCS @biggerthan24
  JMP @notbiggerthan24
  @biggerthan24:

  LDA #$71
  STA middle_corner_up_left
  LDA #$72
  STA middle_corner_up_right
  LDA #$73
  STA middle_corner_down_left
  LDA #$74
  STA middle_corner_down_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  STA corner_up_left_13
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  STA corner_up_right_13
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  STA corner_down_left_13
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12
  STA corner_down_right_13

  JMP @end
  @notbiggerthan24:
  CMP #$18
  BCS @biggerthan23
  JMP @notbiggerthan23
  @biggerthan23:

  LDA #$2C
  STA middle_corner_up_left
  LDA #$2D
  STA middle_corner_up_right
  LDA #$2E
  STA middle_corner_down_left
  LDA #$2F
  STA middle_corner_down_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  STA corner_up_left_13
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  STA corner_up_right_13
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  STA corner_down_left_13
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12
  STA corner_down_right_13

  JMP @end
  @notbiggerthan23:
  CMP #$17
  BCS @biggerthan22
  JMP @notbiggerthan22
  @biggerthan22:

  LDA #$61
  STA corner_up_left_13
  LDA #$62
  STA corner_up_right_13
  LDA #$63
  STA corner_down_left_13
  LDA #$64
  STA corner_down_right_13
  LDA #$54
  STA s2_up_left
  STA s2_up_right
  LDA #$55
  STA s2_down_left
  STA s2_down_right
  LDA #$33
  STA s2_middle_1_left 
  STA s2_middle_2_left 
  LDA #$32
  STA s2_middle_1_right
  STA s2_middle_2_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12
  

  JMP @end
  @notbiggerthan22:
  CMP #$16
  BCS @biggerthan21
  JMP @notbiggerthan21
  @biggerthan21:

  LDA #$5D
  STA corner_up_left_13
  LDA #$5E
  STA corner_up_right_13
  LDA #$5F
  STA corner_down_left_13
  LDA #$60
  STA corner_down_right_13
  LDA #$56
  STA s2_up_left
  STA s2_up_right
  LDA #$57
  STA s2_down_left
  STA s2_down_right
  LDA #$35
  STA s2_middle_1_left 
  STA s2_middle_2_left 
  LDA #$34
  STA s2_middle_1_right
  STA s2_middle_2_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12

  JMP @end
  @notbiggerthan21:
  CMP #$15
  BCS @biggerthan20
  JMP @notbiggerthan20
  @biggerthan20:

  LDA #$65
  STA corner_up_left_13
  LDA #$66
  STA corner_up_right_13
  LDA #$67
  STA corner_down_left_13
  LDA #$68
  STA corner_down_right_13
  LDA #$58
  STA s2_up_left
  STA s2_up_right
  LDA #$59
  STA s2_down_left
  STA s2_down_right
  LDA #$37
  STA s2_middle_1_left 
  STA s2_middle_2_left 
  LDA #$36
  STA s2_middle_1_right
  STA s2_middle_2_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12

  JMP @end
  @notbiggerthan20:
  CMP #$14
  BCS @biggerthan19
  JMP @notbiggerthan19
  @biggerthan19:

  LDA #$69
  STA corner_up_left_13
  LDA #$6A
  STA corner_up_right_13
  LDA #$6B
  STA corner_down_left_13
  LDA #$6C
  STA corner_down_right_13
  LDA #$59
  STA s2_up_left
  STA s2_up_right
  LDA #$58
  STA s2_down_left
  STA s2_down_right
  LDA #$36
  STA s2_middle_1_left 
  STA s2_middle_2_left 
  LDA #$37
  STA s2_middle_1_right
  STA s2_middle_2_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12

  JMP @end
  @notbiggerthan19:
  CMP #$13
  BCS @biggerthan18
  JMP @notbiggerthan18
  @biggerthan18:

  LDA #$6D
  STA corner_up_left_13
  LDA #$6E
  STA corner_up_right_13
  LDA #$6F
  STA corner_down_left_13
  LDA #$70
  STA corner_down_right_13
  LDA #$57
  STA s2_up_left
  STA s2_up_right
  LDA #$56
  STA s2_down_left
  STA s2_down_right
  LDA #$34
  STA s2_middle_1_left 
  STA s2_middle_2_left 
  LDA #$35
  STA s2_middle_1_right
  STA s2_middle_2_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12

  JMP @end
  @notbiggerthan18:
  CMP #$12
  BCS @biggerthan17
  JMP @notbiggerthan17
  @biggerthan17:

  LDA #$2C
  STA corner_up_left_13
  LDA #$2D
  STA corner_up_right_13
  LDA #$2E
  STA corner_down_left_13
  LDA #$2F
  STA corner_down_right_13
  LDA #$52
  STA s2_up_left
  STA s2_up_right
  LDA #$53
  STA s2_down_left
  STA s2_down_right
  LDA #$30
  STA s2_middle_1_left 
  STA s2_middle_2_left 
  LDA #$31
  STA s2_middle_1_right
  STA s2_middle_2_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  STA corner_up_left_12
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  STA corner_up_right_12
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  STA corner_down_left_12
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11
  STA corner_down_right_12

  JMP @end
  @notbiggerthan17:
  CMP #$11
  BCS @biggerthan16
  JMP @notbiggerthan16
  @biggerthan16:

  LDA #$61
  STA corner_up_left_12
  LDA #$62
  STA corner_up_right_12
  LDA #$63
  STA corner_down_left_12
  LDA #$64
  STA corner_down_right_12
  LDA #$54
  STA s3_up_1_left
  STA s3_up_2_left
  STA s3_up_1_right
  STA s3_up_2_right
  LDA #$55
  STA s3_down_1_left
  STA s3_down_2_left
  STA s3_down_1_right
  STA s3_down_2_right
  LDA #$33
  STA s3_middle_1_left
  STA s3_middle_2_left
  STA s3_middle_3_left
  STA s3_middle_4_left
  LDA #$32
  STA s3_middle_1_right
  STA s3_middle_2_right
  STA s3_middle_3_right
  STA s3_middle_4_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11

  JMP @end
  @notbiggerthan16:
  CMP #$10
  BCS @biggerthan15
  JMP @notbiggerthan15
  @biggerthan15:

  LDA #$5D
  STA corner_up_left_12
  LDA #$5E
  STA corner_up_right_12
  LDA #$5F
  STA corner_down_left_12
  LDA #$60
  STA corner_down_right_12
  LDA #$56
  STA s3_up_1_left
  STA s3_up_2_left
  STA s3_up_1_right
  STA s3_up_2_right
  LDA #$57
  STA s3_down_1_left
  STA s3_down_2_left
  STA s3_down_1_right
  STA s3_down_2_right
  LDA #$35
  STA s3_middle_1_left
  STA s3_middle_2_left
  STA s3_middle_3_left
  STA s3_middle_4_left
  LDA #$34
  STA s3_middle_1_right
  STA s3_middle_2_right
  STA s3_middle_3_right
  STA s3_middle_4_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11

  JMP @end
  @notbiggerthan15:
  CMP #$0F
  BCS @biggerthan14
  JMP @notbiggerthan14
  @biggerthan14:

  LDA #$69
  STA corner_up_left_12
  LDA #$6A
  STA corner_up_right_12
  LDA #$6B
  STA corner_down_left_12
  LDA #$6C
  STA corner_down_right_12
  LDA #$59
  STA s3_up_1_left
  STA s3_up_2_left
  STA s3_up_1_right
  STA s3_up_2_right
  LDA #$58
  STA s3_down_1_left
  STA s3_down_2_left
  STA s3_down_1_right
  STA s3_down_2_right
  LDA #$36
  STA s3_middle_1_left
  STA s3_middle_2_left
  STA s3_middle_3_left
  STA s3_middle_4_left
  LDA #$37
  STA s3_middle_1_right
  STA s3_middle_2_right
  STA s3_middle_3_right
  STA s3_middle_4_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11

  JMP @end
  @notbiggerthan14:
  CMP #$0E
  BCS @biggerthan13
  JMP @notbiggerthan13
  @biggerthan13:

  LDA #$6D
  STA corner_up_left_12
  LDA #$6E
  STA corner_up_right_12
  LDA #$6F
  STA corner_down_left_12
  LDA #$70
  STA corner_down_right_12
  LDA #$57
  STA s3_up_1_left
  STA s3_up_2_left
  STA s3_up_1_right
  STA s3_up_2_right
  LDA #$56
  STA s3_down_1_left
  STA s3_down_2_left
  STA s3_down_1_right
  STA s3_down_2_right
  LDA #$34
  STA s3_middle_1_left
  STA s3_middle_2_left
  STA s3_middle_3_left
  STA s3_middle_4_left
  LDA #$35
  STA s3_middle_1_right
  STA s3_middle_2_right
  STA s3_middle_3_right
  STA s3_middle_4_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11

  JMP @end
  @notbiggerthan13:
  CMP #$0D
  BCS @biggerthan12
  JMP @notbiggerthan12
  @biggerthan12:

  LDA #$2C
  STA corner_up_left_12
  LDA #$2D
  STA corner_up_right_12
  LDA #$2E
  STA corner_down_left_12
  LDA #$2F
  STA corner_down_right_12
  LDA #$52
  STA s3_up_1_left
  STA s3_up_2_left
  STA s3_up_1_right
  STA s3_up_2_right
  LDA #$53
  STA s3_down_1_left
  STA s3_down_2_left
  STA s3_down_1_right
  STA s3_down_2_right
  LDA #$30
  STA s3_middle_1_left
  STA s3_middle_2_left
  STA s3_middle_3_left
  STA s3_middle_4_left
  LDA #$31
  STA s3_middle_1_right
  STA s3_middle_2_right
  STA s3_middle_3_right
  STA s3_middle_4_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  STA corner_up_left_11
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  STA corner_up_right_11
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  STA corner_down_left_11
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10
  STA corner_down_right_11

  JMP @end
  @notbiggerthan12:
  CMP #$0C
  BCS @biggerthan11
  JMP @notbiggerthan11
  @biggerthan11:

  LDA #$61
  STA corner_up_left_11
  LDA #$62
  STA corner_up_right_11
  LDA #$63
  STA corner_down_left_11
  LDA #$64
  STA corner_down_right_11
  LDA #$54
  STA s4_up_1_left
  STA s4_up_2_left
  STA s4_up_3_left
  STA s4_up_1_right
  STA s4_up_2_right
  STA s4_up_3_right
  LDA #$55
  STA s4_down_1_left
  STA s4_down_2_left
  STA s4_down_3_left
  STA s4_down_1_right
  STA s4_down_2_right
  STA s4_down_3_right
  LDA #$33
  STA s4_middle_1_left
  STA s4_middle_2_left
  STA s4_middle_3_left
  STA s4_middle_4_left
  STA s4_middle_5_left
  STA s4_middle_6_left
  LDA #$32
  STA s4_middle_1_right
  STA s4_middle_2_right
  STA s4_middle_3_right
  STA s4_middle_4_right
  STA s4_middle_5_right
  STA s4_middle_6_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10

  JMP @end
  @notbiggerthan11:
  CMP #$0B
  BCS @biggerthan10
  JMP @notbiggerthan10
  @biggerthan10:

  LDA #$65
  STA corner_up_left_11
  LDA #$66
  STA corner_up_right_11
  LDA #$67
  STA corner_down_left_11
  LDA #$68
  STA corner_down_right_11
  LDA #$58
  STA s4_up_1_left
  STA s4_up_2_left
  STA s4_up_3_left
  STA s4_up_1_right
  STA s4_up_2_right
  STA s4_up_3_right
  LDA #$59
  STA s4_down_1_left
  STA s4_down_2_left
  STA s4_down_3_left
  STA s4_down_1_right
  STA s4_down_2_right
  STA s4_down_3_right
  LDA #$37
  STA s4_middle_1_left
  STA s4_middle_2_left
  STA s4_middle_3_left
  STA s4_middle_4_left
  STA s4_middle_5_left
  STA s4_middle_6_left
  LDA #$36
  STA s4_middle_1_right
  STA s4_middle_2_right
  STA s4_middle_3_right
  STA s4_middle_4_right
  STA s4_middle_5_right
  STA s4_middle_6_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10

  JMP @end
  @notbiggerthan10:
  CMP #$0A
  BCS @biggerthan9
  JMP @notbiggerthan9
  @biggerthan9:

  LDA #$6D
  STA corner_up_left_11
  LDA #$6E
  STA corner_up_right_11
  LDA #$6F
  STA corner_down_left_11
  LDA #$70
  STA corner_down_right_11
  LDA #$57
  STA s4_up_1_left
  STA s4_up_2_left
  STA s4_up_3_left
  STA s4_up_1_right
  STA s4_up_2_right
  STA s4_up_3_right
  LDA #$56
  STA s4_down_1_left
  STA s4_down_2_left
  STA s4_down_3_left
  STA s4_down_1_right
  STA s4_down_2_right
  STA s4_down_3_right
  LDA #$34
  STA s4_middle_1_left
  STA s4_middle_2_left
  STA s4_middle_3_left
  STA s4_middle_4_left
  STA s4_middle_5_left
  STA s4_middle_6_left
  LDA #$35
  STA s4_middle_1_right
  STA s4_middle_2_right
  STA s4_middle_3_right
  STA s4_middle_4_right
  STA s4_middle_5_right
  STA s4_middle_6_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10

  JMP @end
  @notbiggerthan9:
  CMP #$09
  BCS @biggerthan8
  JMP @notbiggerthan8
  @biggerthan8:

  LDA #$2C
  STA corner_up_left_11
  LDA #$2D
  STA corner_up_right_11
  LDA #$2E
  STA corner_down_left_11
  LDA #$2F
  STA corner_down_right_11
  LDA #$52
  STA s4_up_1_left
  STA s4_up_2_left
  STA s4_up_3_left
  STA s4_up_1_right
  STA s4_up_2_right
  STA s4_up_3_right
  LDA #$53
  STA s4_down_1_left
  STA s4_down_2_left
  STA s4_down_3_left
  STA s4_down_1_right
  STA s4_down_2_right
  STA s4_down_3_right
  LDA #$30
  STA s4_middle_1_left
  STA s4_middle_2_left
  STA s4_middle_3_left
  STA s4_middle_4_left
  STA s4_middle_5_left
  STA s4_middle_6_left
  LDA #$31
  STA s4_middle_1_right
  STA s4_middle_2_right
  STA s4_middle_3_right
  STA s4_middle_4_right
  STA s4_middle_5_right
  STA s4_middle_6_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  STA corner_up_left_10
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  STA corner_up_right_10
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  STA corner_down_left_10
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9
  STA corner_down_right_10

  JMP @end
  @notbiggerthan8:
  CMP #$08
  BCS @biggerthan7
  JMP @notbiggerthan7
  @biggerthan7:

  LDA #$5D
  STA corner_up_left_10
  LDA #$5E
  STA corner_up_right_10
  LDA #$5F
  STA corner_down_left_10
  LDA #$60
  STA corner_down_right_10
  LDA #$56
  STA s5_up_1_left
  STA s5_up_2_left
  STA s5_up_3_left
  STA s5_up_4_left
  STA s5_up_1_right
  STA s5_up_2_right
  STA s5_up_3_right
  STA s5_up_4_right
  LDA #$57
  STA s5_down_1_left
  STA s5_down_2_left
  STA s5_down_3_left
  STA s5_down_4_left
  STA s5_down_1_right
  STA s5_down_2_right
  STA s5_down_3_right
  STA s5_down_4_right
  LDA #$35
  STA s5_middle_1_left
  STA s5_middle_2_left
  STA s5_middle_3_left
  STA s5_middle_4_left
  STA s5_middle_5_left
  STA s5_middle_6_left
  STA s5_middle_7_left
  STA s5_middle_8_left
  LDA #$34
  STA s5_middle_1_right
  STA s5_middle_2_right
  STA s5_middle_3_right
  STA s5_middle_4_right
  STA s5_middle_5_right
  STA s5_middle_6_right
  STA s5_middle_7_right
  STA s5_middle_8_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9

  JMP @end
  @notbiggerthan7:
  CMP #$07
  BCS @biggerthan6
  JMP @notbiggerthan6
  @biggerthan6:

  LDA #$69
  STA corner_up_left_10
  LDA #$6A
  STA corner_up_right_10
  LDA #$6B
  STA corner_down_left_10
  LDA #$6C
  STA corner_down_right_10
  LDA #$59
  STA s5_up_1_left
  STA s5_up_2_left
  STA s5_up_3_left
  STA s5_up_4_left
  STA s5_up_1_right
  STA s5_up_2_right
  STA s5_up_3_right
  STA s5_up_4_right
  LDA #$58
  STA s5_down_1_left
  STA s5_down_2_left
  STA s5_down_3_left
  STA s5_down_4_left
  STA s5_down_1_right
  STA s5_down_2_right
  STA s5_down_3_right
  STA s5_down_4_right
  LDA #$36
  STA s5_middle_1_left
  STA s5_middle_2_left
  STA s5_middle_3_left
  STA s5_middle_4_left
  STA s5_middle_5_left
  STA s5_middle_6_left
  STA s5_middle_7_left
  STA s5_middle_8_left
  LDA #$37
  STA s5_middle_1_right
  STA s5_middle_2_right
  STA s5_middle_3_right
  STA s5_middle_4_right
  STA s5_middle_5_right
  STA s5_middle_6_right
  STA s5_middle_7_right
  STA s5_middle_8_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9

  JMP @end
  @notbiggerthan6:
  CMP #$06
  BCS @biggerthan5
  JMP @notbiggerthan5
  @biggerthan5:

  LDA #$71
  STA corner_up_left_10
  LDA #$72
  STA corner_up_right_10
  LDA #$73
  STA corner_down_left_10
  LDA #$74
  STA corner_down_right_10
  LDA #$55
  STA s5_up_1_left
  STA s5_up_2_left
  STA s5_up_3_left
  STA s5_up_4_left
  STA s5_up_1_right
  STA s5_up_2_right
  STA s5_up_3_right
  STA s5_up_4_right
  LDA #$54
  STA s5_down_1_left
  STA s5_down_2_left
  STA s5_down_3_left
  STA s5_down_4_left
  STA s5_down_1_right
  STA s5_down_2_right
  STA s5_down_3_right
  STA s5_down_4_right
  LDA #$32
  STA s5_middle_1_left
  STA s5_middle_2_left
  STA s5_middle_3_left
  STA s5_middle_4_left
  STA s5_middle_5_left
  STA s5_middle_6_left
  STA s5_middle_7_left
  STA s5_middle_8_left
  LDA #$33
  STA s5_middle_1_right
  STA s5_middle_2_right
  STA s5_middle_3_right
  STA s5_middle_4_right
  STA s5_middle_5_right
  STA s5_middle_6_right
  STA s5_middle_7_right
  STA s5_middle_8_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  STA corner_up_left_9
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  STA corner_up_right_9
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  STA corner_down_left_9
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8
  STA corner_down_right_9

  JMP @end
  @notbiggerthan5:
  CMP #$05
  BCS @biggerthan4
  JMP @notbiggerthan4
  @biggerthan4:

  LDA #$5D
  STA corner_up_left_9
  LDA #$5E
  STA corner_up_right_9
  LDA #$5F
  STA corner_down_left_9
  LDA #$60
  STA corner_down_right_9
  LDA #$56
  STA s6_up_1_left
  STA s6_up_2_left
  STA s6_up_3_left
  STA s6_up_4_left
  STA s6_up_5_left
  STA s6_up_1_right
  STA s6_up_2_right
  STA s6_up_3_right
  STA s6_up_4_right
  STA s6_up_5_right
  LDA #$57
  STA s6_down_1_left
  STA s6_down_2_left
  STA s6_down_3_left
  STA s6_down_4_left
  STA s6_down_5_left
  STA s6_down_1_right
  STA s6_down_2_right
  STA s6_down_3_right
  STA s6_down_4_right
  STA s6_down_5_right
  LDA #$35
  STA s6_middle_1_left
  STA s6_middle_2_left
  STA s6_middle_3_left
  STA s6_middle_4_left
  STA s6_middle_5_left
  STA s6_middle_6_left
  STA s6_middle_7_left
  STA s6_middle_8_left
  STA s6_middle_9_left
  STA s6_middle_10_left
  LDA #$34
  STA s6_middle_1_right
  STA s6_middle_2_right
  STA s6_middle_3_right
  STA s6_middle_4_right
  STA s6_middle_5_right
  STA s6_middle_6_right
  STA s6_middle_7_right
  STA s6_middle_8_right
  STA s6_middle_9_right
  STA s6_middle_10_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8

  JMP @end
  @notbiggerthan4:
  CMP #$04
  BCS @biggerthan3
  JMP @notbiggerthan3
  @biggerthan3:

  LDA #$6D
  STA corner_up_left_9
  LDA #$6E
  STA corner_up_right_9
  LDA #$6F
  STA corner_down_left_9
  LDA #$70
  STA corner_down_right_9
  LDA #$57
  STA s6_up_1_left
  STA s6_up_2_left
  STA s6_up_3_left
  STA s6_up_4_left
  STA s6_up_5_left
  STA s6_up_1_right
  STA s6_up_2_right
  STA s6_up_3_right
  STA s6_up_4_right
  STA s6_up_5_right
  LDA #$56
  STA s6_down_1_left
  STA s6_down_2_left
  STA s6_down_3_left
  STA s6_down_4_left
  STA s6_down_5_left
  STA s6_down_1_right
  STA s6_down_2_right
  STA s6_down_3_right
  STA s6_down_4_right
  STA s6_down_5_right
  LDA #$34
  STA s6_middle_1_left
  STA s6_middle_2_left
  STA s6_middle_3_left
  STA s6_middle_4_left
  STA s6_middle_5_left
  STA s6_middle_6_left
  STA s6_middle_7_left
  STA s6_middle_8_left
  STA s6_middle_9_left
  STA s6_middle_10_left
  LDA #$35
  STA s6_middle_1_right
  STA s6_middle_2_right
  STA s6_middle_3_right
  STA s6_middle_4_right
  STA s6_middle_5_right
  STA s6_middle_6_right
  STA s6_middle_7_right
  STA s6_middle_8_right
  STA s6_middle_9_right
  STA s6_middle_10_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  STA corner_up_left_8
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  STA corner_up_right_8
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  STA corner_down_left_8
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7
  STA corner_down_right_8

  JMP @end
  @notbiggerthan3:
  CMP #$03
  BCS @biggerthan2
  JMP @notbiggerthan2
  @biggerthan2:

  LDA #$61
  STA corner_up_left_8
  LDA #$62
  STA corner_up_right_8
  LDA #$63
  STA corner_down_left_8
  LDA #$64
  STA corner_down_right_8
  LDA #$54
  STA s7_up_1_left
  STA s7_up_2_left
  STA s7_up_3_left
  STA s7_up_4_left
  STA s7_up_5_left
  STA s7_up_6_left
  STA s7_up_1_right
  STA s7_up_2_right
  STA s7_up_3_right
  STA s7_up_4_right
  STA s7_up_5_right
  STA s7_up_6_right
  LDA #$55
  STA s7_down_1_left
  STA s7_down_2_left
  STA s7_down_3_left
  STA s7_down_4_left
  STA s7_down_5_left
  STA s7_down_6_left
  STA s7_down_1_right
  STA s7_down_2_right
  STA s7_down_3_right
  STA s7_down_4_right
  STA s7_down_5_right
  STA s7_down_6_right
  LDA #$33
  STA s7_middle_1_left
  STA s7_middle_2_left
  STA s7_middle_3_left
  STA s7_middle_4_left
  STA s7_middle_5_left
  STA s7_middle_6_left
  STA s7_middle_7_left
  STA s7_middle_8_left
  STA s7_middle_9_left
  STA s7_middle_10_left
  STA s7_middle_11_left
  STA s7_middle_12_left
  LDA #$32
  STA s7_middle_1_right
  STA s7_middle_2_right
  STA s7_middle_3_right
  STA s7_middle_4_right
  STA s7_middle_5_right
  STA s7_middle_6_right
  STA s7_middle_7_right
  STA s7_middle_8_right
  STA s7_middle_9_right
  STA s7_middle_10_right
  STA s7_middle_11_right
  STA s7_middle_12_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  STA corner_up_left_7
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  STA corner_up_right_7
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  STA corner_down_left_7
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6
  STA corner_down_right_7

  JMP @end
  @notbiggerthan2:
  CMP #$02
  BCS @biggerthan1
  JMP @notbiggerthan1
  @biggerthan1:

  LDA #$2C
  STA corner_up_left_7
  LDA #$2D
  STA corner_up_right_7
  LDA #$2E
  STA corner_down_left_7
  LDA #$2F
  STA corner_down_right_7
  LDA #$52
  STA s8_up_1_left
  STA s8_up_2_left
  STA s8_up_3_left
  STA s8_up_4_left
  STA s8_up_5_left
  STA s8_up_6_left
  STA s8_up_7_left
  STA s8_up_1_right
  STA s8_up_2_right
  STA s8_up_3_right
  STA s8_up_4_right
  STA s8_up_5_right
  STA s8_up_6_right
  STA s8_up_7_right
  LDA #$53
  STA s8_down_1_left
  STA s8_down_2_left
  STA s8_down_3_left
  STA s8_down_4_left
  STA s8_down_5_left
  STA s8_down_6_left
  STA s8_down_7_left
  STA s8_down_1_right
  STA s8_down_2_right
  STA s8_down_3_right
  STA s8_down_4_right
  STA s8_down_5_right
  STA s8_down_6_right
  STA s8_down_7_right
  LDA #$30
  STA s8_middle_1_left
  STA s8_middle_2_left
  STA s8_middle_3_left
  STA s8_middle_4_left
  STA s8_middle_5_left
  STA s8_middle_6_left
  STA s8_middle_7_left
  STA s8_middle_8_left
  STA s8_middle_9_left
  STA s8_middle_10_left
  STA s8_middle_11_left
  STA s8_middle_12_left
  STA s8_middle_13_left
  STA s8_middle_14_left
  LDA #$31
  STA s8_middle_1_right
  STA s8_middle_2_right
  STA s8_middle_3_right
  STA s8_middle_4_right
  STA s8_middle_5_right
  STA s8_middle_6_right
  STA s8_middle_7_right
  STA s8_middle_8_right
  STA s8_middle_9_right
  STA s8_middle_10_right
  STA s8_middle_11_right
  STA s8_middle_12_right
  STA s8_middle_13_right
  STA s8_middle_14_right

  LDA #$38
  STA corner_up_left_1
  STA corner_up_left_2
  STA corner_up_left_3
  STA corner_up_left_4
  STA corner_up_left_5
  STA corner_up_left_6
  LDA #$39
  STA corner_up_right_1
  STA corner_up_right_2
  STA corner_up_right_3
  STA corner_up_right_4
  STA corner_up_right_5
  STA corner_up_right_6
  LDA #$39
  STA corner_down_left_1
  STA corner_down_left_2
  STA corner_down_left_3
  STA corner_down_left_4
  STA corner_down_left_5
  STA corner_down_left_6
  LDA #$38
  STA corner_down_right_1
  STA corner_down_right_2
  STA corner_down_right_3
  STA corner_down_right_4
  STA corner_down_right_5
  STA corner_down_right_6

  JMP @end
  @notbiggerthan1:
  LDA #$5D
  STA corner_up_left_1
  LDA #$5E
  STA corner_up_right_1
  LDA #$5F
  STA corner_down_left_1
  LDA #$60
  STA corner_down_right_1

  LDA #$56
  STA sE_up_1_left
  STA sE_up_2_left
  STA sE_up_3_left
  STA sE_up_4_left
  STA sE_up_5_left
  STA sE_up_6_left
  STA sE_up_7_left
  STA sE_up_8_left
  STA sE_up_9_left
  STA sE_up_10_left
  STA sE_up_11_left
  STA sE_up_12_left
  STA sE_up_13_left
  STA sE_up_1_right
  STA sE_up_2_right
  STA sE_up_3_right
  STA sE_up_4_right
  STA sE_up_5_right
  STA sE_up_6_right
  STA sE_up_7_right
  STA sE_up_8_right
  STA sE_up_9_right
  STA sE_up_10_right
  STA sE_up_11_right
  STA sE_up_12_right
  STA sE_up_13_right

  LDA #$57
  STA sE_down_1_left
  STA sE_down_2_left
  STA sE_down_3_left
  STA sE_down_4_left
  STA sE_down_5_left
  STA sE_down_6_left
  STA sE_down_7_left
  STA sE_down_8_left
  STA sE_down_9_left
  STA sE_down_10_left
  STA sE_down_11_left
  STA sE_down_12_left
  STA sE_down_13_left
  STA sE_down_1_right
  STA sE_down_2_right
  STA sE_down_3_right
  STA sE_down_4_right
  STA sE_down_5_right
  STA sE_down_6_right
  STA sE_down_7_right
  STA sE_down_8_right
  STA sE_down_9_right
  STA sE_down_10_right
  STA sE_down_11_right
  STA sE_down_12_right
  STA sE_down_13_right

  LDA #$35
  STA sE_middle_1_left
  STA sE_middle_2_left
  STA sE_middle_3_left
  STA sE_middle_4_left
  STA sE_middle_5_left
  STA sE_middle_6_left
  STA sE_middle_7_left
  STA sE_middle_8_left
  STA sE_middle_9_left
  STA sE_middle_10_left
  STA sE_middle_11_left
  STA sE_middle_12_left
  STA sE_middle_13_left
  STA sE_middle_14_left
  STA sE_middle_15_left
  STA sE_middle_16_left
  STA sE_middle_17_left
  STA sE_middle_18_left
  STA sE_middle_19_left
  STA sE_middle_20_left
  STA sE_middle_21_left
  STA sE_middle_22_left
  STA sE_middle_23_left
  STA sE_middle_24_left
  STA sE_middle_25_left
  STA sE_middle_26_left

  LDA #$34
  STA sE_middle_1_right
  STA sE_middle_2_right
  STA sE_middle_3_right
  STA sE_middle_4_right
  STA sE_middle_5_right
  STA sE_middle_6_right
  STA sE_middle_7_right
  STA sE_middle_8_right
  STA sE_middle_9_right
  STA sE_middle_10_right
  STA sE_middle_11_right
  STA sE_middle_12_right
  STA sE_middle_13_right
  STA sE_middle_14_right
  STA sE_middle_15_right
  STA sE_middle_16_right
  STA sE_middle_17_right
  STA sE_middle_18_right
  STA sE_middle_19_right
  STA sE_middle_20_right
  STA sE_middle_21_right
  STA sE_middle_22_right
  STA sE_middle_23_right
  STA sE_middle_24_right
  STA sE_middle_25_right
  STA sE_middle_26_right
  @end:
  RTS

LoadDirectionSprite:
  LDA #$10
  STA $0200
  LDA #$7C
  STA $0203
  LDA direction
  STA $0201
  RTS

paletteData:
  .BYTE $0F,$2A,$10,$30,  $3D,$1D,$00,$30,  $36,$26,$16,$06,  $3A,$2A,$1A,$0A   ;;background palette
  .BYTE $0F,$2A,$10,$30,  $3D,$1D,$00,$30,  $36,$26,$16,$06,  $3A,$2A,$1A,$0A   ;;sprite palette

Maze:
  .BYTE %11111111,%11111111,%11111111,%11111111 ;; bitmap of maze
  .BYTE %10100000,%00100001,%00000000,%00000001 
  .BYTE %10101010,%10101101,%01101110,%11110111
  .BYTE %10001010,%10101001,%01000100,%01000101
  .BYTE %10101000,%10001100,%00010001,%00010101
  .BYTE %10101110,%11111101,%11111111,%01111101
  .BYTE %10100000,%00000000,%00000000,%00000001
  .BYTE %10111101,%11011101,%01111111,%11110111
  .BYTE %10000001,%00000001,%00000100,%00000001
  .BYTE %10110111,%01111101,%01110101,%11111101
  .BYTE %10100000,%01000101,%00000100,%00000001
  .BYTE %10101101,%01010101,%11110111,%11101111
  .BYTE %10100101,%01010101,%00010100,%00000001
  .BYTE %10101101,%01010101,%01010101,%11111101
  .BYTE %10000001,%00000000,%01000000,%00000001
  .BYTE %11111111,%11111111,%11111111,%11111111

.SEGMENT "CHARS"
  .incbin "mazewar.chr"