BEGIN {
last = 0; cnt = 0; test = 0
groupscnt = split("0 15 15 15 15 15 25",score)  # put score for subgroups here
}
/ *# *NEW *GROUP */ {
    printf "tstgroupX(%3d, [%03d..%03d], [%03d..%03d]),\n",test,1,test,last+1,test > "groups.cfg.temp";
    printf "repl([%03d..%03d], \" %.6f \"),\n",last+1,test, (score[cnt+1] *1.0/ (test - last)) > "scoring.cfg.temp";
    cnt += 1;
    last = test;
}
! / *# *NEW *GROUP */{
  test++
}
END {
printf "tstgroupX(%3d, [%03d..%03d], [%03d..%03d])\n",test,1,test,last+1,test > "groups.cfg.temp";
printf "repl([%03d..%03d], \" %.6f \")\n",last+1,test, (score[cnt+1] *1.0/ (test - last)) > "scoring.cfg.temp";
cnt++;
if (cnt != groupscnt)
    printf "Warning: wrong number of groups\n", cnt >"/dev/stderr";
}
