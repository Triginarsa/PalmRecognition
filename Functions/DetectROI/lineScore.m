function score = lineScore(p)

d1 = sqrt((p(2,2)-p(1,2))^2 + (p(2,1)-p(1,1))^2);
d2 = sqrt((p(4,2)-p(3,2))^2 + (p(4,1)-p(3,1))^2);
score = [d1 d2];

end

