Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A9327344
	for <lists+linux-nvdimm@lfdr.de>; Sun, 28 Feb 2021 16:57:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 36EBE100EC1DA;
	Sun, 28 Feb 2021 07:57:51 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=120.229.105.27; helo=kxwcq.com; envelope-from=awmhm@kxwcq.com; receiver=<UNKNOWN> 
Received: from kxwcq.com (unknown [120.229.105.27])
	by ml01.01.org (Postfix) with ESMTP id 36DF2100EF26A
	for <linux-nvdimm@lists.01.org>; Sun, 28 Feb 2021 07:57:26 -0800 (PST)
Received: from desktop ([127.0.0.1]) by localhost via TCP with ESMTPA; Mon, 08 Mar 2021 00:00:56 +0800
Message-ID: 21b33499-7e06-43bc-a345-900d13a78709
MIME-Version: 1.0
Sender: =?utf-8?Q?=E8=A7=A3=E5=86=B3=E9=A6=99=E6=B8=AF=E8=B7?=
 =?utf-8?Q?=A8=E5=A2=83=E8=BD=A6=E8=BE=86=EF=BC=8C=E4=BC=81=E4=B8=9A=E5?=
 =?utf-8?Q?=9C=BA=E5=9C=B0=E7=A0=81=EF=BC=8C=E9=A6=99=E6=B8=AF=E5=8F=B8?=
 =?utf-8?Q?=E6=9C=BA=E6=8E=A5=E9=A9=B3=EF=BC=81=E4=B8=AD=E8=BD=AC=E4=BB?=
 =?utf-8?Q?=93=E5=82=A8=E3=80=81=E8=A3=85=E5=8D=B8=E8=BF=90=E8=BE=93=E6?=
 =?utf-8?Q?=8A=A5=E5=85=B3=E4=B8=80=E6=9D=A1=E9=BE=99=E6=9C=8D=E5=8A=A1?=
 <awmhm@kxwcq.com>
From: =?utf-8?Q?=E8=A7=A3=E5=86=B3=E9=A6=99=E6=B8=AF=E8=B7=A8?=
 =?utf-8?Q?=E5=A2=83=E8=BD=A6=E8=BE=86=EF=BC=8C=E4=BC=81=E4=B8=9A=E5=9C?=
 =?utf-8?Q?=BA=E5=9C=B0=E7=A0=81=EF=BC=8C=E9=A6=99=E6=B8=AF=E5=8F=B8=E6?=
 =?utf-8?Q?=9C=BA=E6=8E=A5=E9=A9=B3=EF=BC=81=E4=B8=AD=E8=BD=AC=E4=BB=93?=
 =?utf-8?Q?=E5=82=A8=E3=80=81=E8=A3=85=E5=8D=B8=E8=BF=90=E8=BE=93=E6=8A?=
 =?utf-8?Q?=A5=E5=85=B3=E4=B8=80=E6=9D=A1=E9=BE=99=E6=9C=8D=E5=8A=A1?=
 <wuliu56sales01@hotmail.com>
To: linux-nvdimm@lists.01.org
Date: 8 Mar 2021 00:00:56 +0800
Subject: =?utf-8?B?6Kej5Yaz6aaZ5riv6Leo5aKD6L2m6L6G77yM5LyB5Lia5Zy6?=
 =?utf-8?B?5Zyw56CB77yM6aaZ5riv5Y+45py65o6l6amz77yB5Lit6L2s5LuT5YKo?=
 =?utf-8?B?44CB6KOF5Y246L+Q6L6T5oql5YWz5LiA5p2h6b6Z5pyN5Yqh?=
Message-ID-Hash: SK445CJOCNVUQNWA7UGDG7BYR3CH4664
X-Message-ID-Hash: SK445CJOCNVUQNWA7UGDG7BYR3CH4664
X-MailFrom: awmhm@kxwcq.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SK445CJOCNVUQNWA7UGDG7BYR3CH4664/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Jm5ic3A7DQrop6PlhrPpppnmuK/ot6jlooPovabovobvvIzkvIHkuJrlnLrlnLDnoIHvvIzpppnm
uK/lj7jmnLrmjqXpqbPvvIENCui0p+eJqei/m+WHuuWPo++8jOS4rei9rOS7k+WCqOOAgeijheWN
uOi/kOi+k+aKpeWFs+S4gOadoem+meacjeWKoQ0K5Lit5riv6LSn6L+Q5pyJ6ZmQ5YWs5Y+46IGU
57O75Lq677yaSmFja01vYmlsZSDvvJorODYtMTM2NDI5ODA5MzXvvIjlvq7kv6HlkIzlj7fvvIlF
LW1haWwg77yaIHd1bGl1NTZzYWxlczAxQGhvdG1haWwuY29t6aaZIOa4r++8muiRtea2jOS4ieWP
t+i0p+afnOeggeWktOeJqea1geS4reW/gyBB5bqn5Zyw5LiLDQombmJzcDsNCg0KMjAyMeW5tDAz
5pyIMDjml6UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRv
IHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAx
Lm9yZwo=
