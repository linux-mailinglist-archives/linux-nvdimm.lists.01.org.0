Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CF934596D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Mar 2021 09:15:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C3286100EC1E7;
	Tue, 23 Mar 2021 01:15:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.163.191.173; helo=sonic304-47.consmr.mail.ne1.yahoo.com; envelope-from=mariamsterbenc@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic304-47.consmr.mail.ne1.yahoo.com (sonic304-47.consmr.mail.ne1.yahoo.com [66.163.191.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E79D3100ED487
	for <linux-nvdimm@lists.01.org>; Tue, 23 Mar 2021 01:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1616487346; bh=JDwVg1YeWij1bzVg6CXUMNyKMzRE7Mu8E1jiUyK+aHk=; h=Date:From:Reply-To:Subject:References:From:Subject:Reply-To; b=bqstHl1BhFAVj6mgN9cbyOaeLKTKRdsBEsVuqdqB6eFysgmhwvSitGmBI8UwiOclUnlp4UBDUJZzKCs6FRyPBvhJ8v8tzJXiqhC+Kb5D/PVn3qgMZ/mXWsVjhsBrBHn3Un1Y/UeSpjcP9vuHAg6vdLdVoIuPv6rO2Inh+HViS8jVH+d12yd0XL7MVsx/Uvkov/R6xikaZ7n7qW04qpwk1X2hqhrQd1H6kTXvHoMoEktSoCUejQ1WBqoLJ0TjYXS/ONxJ/mQ5+WwYQziBfRuw/b6OxQLGiGvbaTWPsUgTix5NQlGUQjpkpcdwzNCygW5mxfDNs0XIl3aOs5AWRV6BnA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1616487346; bh=9CQnlkWkMI08wo/Wzecki1oz8V6nSlU0ko8yZUKTC/J=; h=X-Sonic-MF:Date:From:Subject:From:Subject; b=TRLBC4ixqoH9wHrbc29D8h+gT3y2MP5tJTYv1y1H2+82MIDy6qpjfGw8K4EOAp4dKchIo8VweKPnAJ3AsvG3FIFeIjGsvn9h7hiMeF1yGPwx5iAWHVN9O1r2eRZEzB/to6JdNlk5+9aivqgkBXRIu1KjEXs6P6rYISOsHZ39r9JOUBAbz5dAQHcaHOt0pSDPR25zfu6JFUkiJVyBjRBJQ0AWSxzLHzsXhCiD6mvOOSWU/gCUJz9G0pNeQjm8eZiTh7HKB6OxR2d7bm65eZSt6RW9wkWkNX/ewnqU1S3KTxM+ptCO13DqIAamD6dL93rTr5OAOFDokTAF2xGYikh7Pw==
X-YMail-OSG: kvxcCOwVM1niuOE2915OfCQfq1d7ewYQosYKnOSuGjQG_PG.N_e._B_niPFcd8T
 8itH1HymQMG8o9ZUdjqzn.5kljl.5xGQtB9mO5LapIvZ2PvBMozpo6WCZE2sTDpICP6SL804jnk1
 k8D6bUITAAc3U4vKTOyxT5w03cDUgAzea19VvTeWZ1WQ0OLdBFv0daYVj5As5Ief0kYfJ2XDsqaH
 zhrzIbosuEDZW6q.rvmpTEvXQH6yK2ZU64TB84vvx0S.JgjF_iAzgquIKGo6C0E8AoeFdrbG6FFs
 MbfDLFJ33xOjCWIvJYJqnRDHvYLE4gPlD1CXqFjCVM6bY8AjSxHukjyBqGAe6AdM78NSw6I7FyhP
 8LsiHKaYWtTyjuQXHk10.mabUuGm5ts2qduUfVPq1o99X_np6_myj.fXOlcJw_XZKCuQWiBg64XT
 KdnjsIVjFRWY7zoKA6th5IoLXu6kERQtgq8yGF_y9LpI9hFpF3DGyMoADab01pGR.LsxBaZ5ymog
 sJ2nJ_JHHwph2ksJbBJ2OAQYs9L1ISxtaBVew.dccVOagc4PpN.wNrAvS5vopVB5u3Zbx6x8A3ug
 ugEFzIz9nRDMmc9H3hB82UJ2a0Rr1m..y7T5hw9A43G4AH.n.5Q6yPuczNvsZ4hJWEUlR5rH3w51
 sOYoQ7q6wL_DgmD4pl.4uyuM6L3nHRWxT0rgRJ5HEx.cXVtc91EaV5vqurm9EMu7fFZbCxuc4wll
 npFUGAL3J6De_NvnJBWNnjykv5Ack43JXOKeC42KKqDp9pTKebksXTsr9Wsg2qZ5vfonO1k0KXnT
 jXFrCo6jN5xJldZ8YNhddepwz_4a88dF8NRwXTAxu7DgK.xj7LOIFxxCnTYH9p57US7aNrm2GTMn
 pbJD0ejHEVEB7w136lm4XII3okm6c_XyfcRGib9nZ7JMDwu7D3cYvLdy8fmat4KrmK2IStmcrkqd
 9Zkdlf1ImbnSyKj2gZxv8d4.Dn5.6oapzMpNLOBQP7SzEKNeNiVMGDl7XKH0gyhkDoTYK7eOZMxq
 G5zhqOXvpzgamMmYYd3B114qBu_YWNkJva6G2JIXePwglRqrFhh2.sGFIFUCuDF2E.FIQOZHzEWV
 GhpI6Nqkvgu4MI_VYTC6oru9D.rBs2gw3YES_f2_36BlXCKqOwFw3frZxRFZ1pGvveAy7KIczuWL
 O7KREOeSppNTyeE1iyf.7DyY1iLlqAAZ2ZZEb2S3hnNHCxSdFr5bMOgpHvgWQx9zTI3yy6lzyN9A
 0EjEH1wSqZUUhrxuZBHT2m5cM9_AXhDJg21u3avvKGmQIp3byNqrnF5.77hv4O0apaKkpk6HoEVS
 w.Ze9lw9M19U2WhB7CKvGfsCGOCGQY5iU8aVZ6NhfEQg.3uqgmoKkB.wzql9VCyD1YCMkcolR_rH
 0HfXn91pFP1HqjslRwwFGDkvCPGxu_xnTrScXGTm2gucy39PnBuH7E40LYmxhwfnl08weNVOKWxE
 8KIZV.vIbqhcz7CNoc4JS02.9nGc0oVVnbGnabNL2pYz2PKCRuTNm5Tch9v7yECAm3UDiQgFUxG1
 2LiX1E6qkHx.G3pYlSAGTXlvgshm.U.LXPzxMZ_De2.EhQspuvnhOqlRDtMROjr.czs505QspB4c
 huF_l78tCYoK75T0r7wDL8q7kBbUXkB4u36rsxFp5vvGZfvHExW8dRlkx89T0e6HK.t49OlXwGwZ
 R2V5vj.CelSa91snhqNev6T4mYDGgLiKPsNqWyuLvBtsJyFQNEkdAAy5FvwWSxd_5q22ZdKd51Mc
 rCZygYuYBfu_gYTfzxrDERQLnpbLF.x0lXEJevelOYu5oGN1FHzv7Lnx9wtmSGO.s88_oCnosj39
 l7pxivRwuYHXjD.fKYqTGCY71aOLYphymUU2l2isnKECkZfB8W8GOQTEt.O325LpNziAE9sDbe_p
 RKKdIxb6w5UiyYurP1d4rjdGKvCkoE0zikAQNRo_Z3gvFXc3grj6s0u8mfr1Tbs7fI55PTKMzBqA
 2fQ2leCcBnruTHm5KOgJxYS5699zcqZsQYXJZBCRifIEJIlik7gRd.Ial9bcihqsoqLAVAQWOel.
 p2FBvNct33gzdVwVik5_75ZQrVYlYprwmSM_LL65hcB5mVB7Qt761NcuRy_A1BX.FDK4JoxEe.hi
 UlpyDJB4pF9gsv4YDN6OXZwKDjRRyUh3NuQLabCdLfDdNX6BQokPcuuX.Gqrr6VdNrVD0jWJEl.H
 DIsOuF7M1YkLX0lkxyAZyCVDMENz5sYgP8lHYqWzLGNtJFOKQIs7Pj66VgTJ24ObNScUKwFIUSkn
 kIRi3uRMp.5hDZHziuEFAvbuwiDBtRdxTXk1uad6u16yr9FVOT_TqCn20AYi7EJxFgyp9Wx9BgU9
 lU71jI22CZZJQGyr7_ExEGP.QiSAR7LlbQ6mZjvHvH0GyLf7inoHr3Sx2aXka13kZQMK3b1z25FI
 bYzFl.mZqaiiDnlnILfi9Fi5kzHcUXcEC.z6PLQF3DjlglF1xSSHPz6HVpcRiBZZesQMJ1KxspR7
 _vKTdMLDZ11R3xR1_yAEFcWIuSgfO93fw8mKgyM9IZ57ZQNjyiIsGiSG.s1eLwlPqe7kOizRYNCq
 D0OH1DoBGWtZ9xq2GUrX8HN1YVdt3cjv52eCMlF4WmHJ4N5w672oCsF8pIyTC8raZpjxIkCAcGJi
 kt5P9vX1wDORtG4R9XFzfsni6utkmmFa6E9vnzTXRoDoxNhku.0CDBpV6pJupVH8L1Kk.QOMMUw7
 I_QZgxzPxxzD6NrNS8VERVD91W0hHu9PR6yfv2_vr_Yq0rkgh1Zju98XxeTSrhUkjjYzanGdOQAX
 IOjwLcPGdY_FgUCyRdsKes4cuFQo1mw0biKgxp1wBC9H8mjBg2OOSbUpS8lhRA4zvqayNmtaYL96
 MK56qofMmRVHw0OswB8.8KjQupy.ZnKxOL.0ywwiFH6amk_Ap9cvBgqvZK6s0.pt0IBUi8IsI4my
 H23SMt5oElEveyp7s8_CdqXdWtQ2p7frKCqFopgxAqi3InTEE3Bo.2RvyFH29_C84DHhZhXdw6.w
 Wt.BHn_ocBofw3uiWn4ksmljCvst85j8Gt_8dDKUL4XSIBy9Uvi2eYWQmULz2SRetLpO2Byd.ol2
 NdVKI912uYuxsjwdFk7XWAljCWSYe8MYfNMifC8V4KdyyqWLpOv.fYDBubsgw58rTM9J.x3_31ye
 PZtWBl5TNYg9S39SCk7yvIDhikSl_YpzKAIb_yydBao9TUwF490XkVxjfRrDrSX_Nthzp18hTrwO
 eg6vyy7zWTELQ4mWREhvy7CizTjiAFREXcxpkuSh._gTXz9ejXEM5b6NKkPf1VIHypcg5U4oW.a3
 dcC93AoQr9.ylXslrkMiVPUr1glxIPIT0m3I8EDGNK82wcPNkzLpsnMJQt5DJmc8_tWQdvyIaXiP
 yPTZ54V.b4nRPIMEnDtWSoNwITtAO9FOPpybhy_Ik6hNE6P2xEkOktIMbqYptJV0ChZW.hb8F_xc
 xIf1pPIUpTnvLjFtBU5xBMmgLYT7evJcr5WAMxwwTK.NmoDvBQqsN0njkV5tYPKYFRNdg3YzOS6E
 J2nHNTUAaQKO9PNl2OHuVLsC9bGZozdgcGRra4O3Brei52dq_i3KSAeNj0ZkyRE0HV9gVIEJz5y2
 0_VwJqk3fiGm3hoQG3rViiYIer2pIeaLvnu8ktXG79rAvfcjbAUU6ncBGl142Y_ZfpWQIQz8pl_h
 _saf.hcp0lq.ymySgyLZXyW1rHxRQFgdagNTKsiaQAG6KJZpWDK9eIS15_UR4wMB42BVIURDcxjt
 V4G.xlZiJHPAFgVQXUKX67mBR0agiMNWJabBsIRbU6wWfbAr.lujHX2oXPiDIDIj2fIjdvAld1bA
 obnUPZoIJF4oEoibLIz5gfIbsSS9poF3heOsUI.Jeeyer3Gi_MdQfgU9Iq8gy6Q_PsNcjUqyiRUH
 q7aTfvlsIWMf7ZgNKJPRJldzd3p7fOi57NvJE6u77AIvoXhuK3ojcbfxhsVq6NGa5WARPgH0rSXV
 5nGKYsSVnIBc3otlYm4u0YssFHi86BUwmZ.sl5VD6qZ0F9rpiPbdyexp5ilnSAI_UwgL78W9oJNS
 00BbVlb7spcvRsXakbfsE_3hJd_Eqpkc50OQuOTsSvOM1tyRyX3Hr2uK89zNHwYJgEEIvUakDipy
 Jd1QJBiwGX8bvvpTQ2Yfx2BbN_Gcnpr.JnXSe0Ob.oDGtS5p0rFU4vxiHIN0vzj1rxofszy3WQ_G
 lp6G0OIz7zS_NwUyQuVoBsUMwwfv1pdhGAfHNvTwXMghDH8jULwAA9WTF8ZXVuEOnbFenoy87C8o
 EeihoLPm6NgdG4e4n4GNwgHR0SorYdVKEO9uOnd7OAxvRlAkCN9kPVpd4V7RHf0NaiJVrq9xGeIe
 CuO.dNSrzqa44mUXHZYUz0aIebrKEJWH8.2_lzN8plEK_uefHoj.Uv8kIwaiTLkpfCPRC5dCuYb.
 LMYW.I_W7eOdcmwRhUcejB5NCrmkyG4RZuP0Brs0m7o79Z7qazNtHNCZE4ytOBuhSwOsBXGi_Nwi
 B08.Jctl8FlnbnvYUnbBiLRprOVDmny4ButyMOH1oTiMy4hB1GZJAfKAPYvbvX.klUQf433MNPla
 k3ALAMmBpM8Jgtxh4Fb4ePmdZKJlxJWSha_1vJZtKIuB0WvT_Q9ne6_0Y8N_ECsGwLVjc87l5jNp
 yzPN6qM8L1AUde_CDaj8cDy_a2W8q4KrxV9WukefFeyd.XiGm52Z02BowZQKydPe1qDgAT_PwuFb
 12BVX_dZwuMBVpvhSdFfXDYundPbPDhVaRJYKdIlMq37XI22_9RTneyuAhY90ehFSAh_Xf1YMSpY
 o6g9kl4yJVcdR96qmq_JAjuPtUsFNya4YN7jmq5lvJ3InNBnGuTv5zTbEBts_9BYAMa8Y07XOsKh
 MPRdz._heGy9wjGIgbBZ3TllLYPG0Ar5nYxjAYXPlwBGVCqUVnUl03poF93PBgGj7c9DwaeGfbvM
 U3i73nZMlxWR7f6VSutPSPD5h5ncNMG6S1del78TE7WZ3it614m3Pdr3QSV2bflfJUlBujCz1DJ9
 STqgYPN8GSVd2aaKehetW3QGAItTKyJ__.WHbmFJT1U8u.orPorR3L6YhI6p7L6jADx2YUdbvQdI
 oByuwc8KdGXZKkTO0W5.GAqh8wR6oBzr1yHL4MK5.V_FBgR6udLEq6f_5_90FDKVX.voVx2eq60d
 uV9Bq44iAaEw43tZhluby3ev1MARvy.mQ.y5a5FJu2mT8NI.CMfFqlTUR8YJkpzeXxGyC899KpSQ
 tx2yK76Q.ZAjx3nCogexrJbPiwjaKFD3nsIz0NfWyhP4H6Q3X1p2o2dtPNY_uZ8l2XHIJlZ075RQ
 7hskLfBKA8a47bc3zs3zzE2GQ7e2XlXuIL8wEPHGYqsagz6U_wYjYMJ6vFq3XuPwAIGME5bGLoNZ
 hCY5UV6zOycueCH3bzWF8zrhrNBKJICbOGHlMj5YjWZKHZIi8WzIXlnN0P5Mi7SLimGk-
X-Sonic-MF: <mariamsterbenc@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 23 Mar 2021 08:15:46 +0000
Date: Tue, 23 Mar 2021 08:13:45 +0000 (UTC)
From: Peter Florian <mariamsterbenc@yahoo.com>
Message-ID: <1898585444.4164033.1616487225478@mail.yahoo.com>
Subject: Hello,
MIME-Version: 1.0
References: <1898585444.4164033.1616487225478.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.17936 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36
Message-ID-Hash: XK3U5SMA7YSF4KC3P4YDPYXQLWOQMLLD
X-Message-ID-Hash: XK3U5SMA7YSF4KC3P4YDPYXQLWOQMLLD
X-MailFrom: mariamsterbenc@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: peterflorian019@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XK3U5SMA7YSF4KC3P4YDPYXQLWOQMLLD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Hello,


My name is Mrs. Peter Florian and I am a British Citizen. My husband died recently on Coronavirus and I am presently in hospital suffering Cancer Disease. My husband has a deposit of 15.200.000 GBP in a prime Bank here in London. Before my husband was taken to Isolation center where he died, he told me to use the funds to establish animal care clinics. We have special love for animals. Due to my present health condition, I will not be able to handle this project. Therefore, I want to donate the 15.200.000.00 GBP to you so that you will set up an animal care Foundation in your country. A clinic where animals will be treated in your country for free. I see in television that people donates funds to orphanage homes and don't care about animals. I and my husband wants to make a difference in the world to let people understand that animals are important to nature. Please let me know your interest so that I will ask my lawyer to prepare a contract Agreement on your name. Please don't forge
 t that my health condition is bad, therefore I want you to reply this message as soon as possible so you will receive the funds before anything happens to me. I am waiting to hear from you.


Thank you,
Mrs. Peter Florian
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
