Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8D6333B44
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 12:24:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 09987100EB32A;
	Wed, 10 Mar 2021 03:24:04 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=212.227.17.24; helo=mout.kundenserver.de; envelope-from=arnd@arndb.de; receiver=<UNKNOWN> 
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6FEE3100EB325
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 03:24:01 -0800 (PST)
Received: from mail-ot1-f42.google.com ([209.85.210.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MNbxN-1l5SKb22l1-00P5Yu for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021
 12:23:58 +0100
Received: by mail-ot1-f42.google.com with SMTP id r24so8946270otq.13
        for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 03:23:57 -0800 (PST)
X-Gm-Message-State: AOAM533nvBDuprLUgEBMYmKaov+JWSxzF7MvRIPwuZCHg1s5VPdDxkN4
	dLGsdZ/Bz3sMXd5qxLihjsOuAEARoBnLLb0AfsU=
X-Google-Smtp-Source: ABdhPJzSi9rQjVmQMcCdC3Ugc0EWFLl//ABE/fGqmyUE3BjBZcH2sAsjResUueB/qNZ0M5JXaPsoktuZzqJxAH31rsg=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr2167623otq.305.1615375436800;
 Wed, 10 Mar 2021 03:23:56 -0800 (PST)
MIME-Version: 1.0
References: <20210309181533.231573-1-willy@infradead.org>
In-Reply-To: <20210309181533.231573-1-willy@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Mar 2021 12:23:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a31=gJkF+GypnaznfhKCYSnwU1yF4u0tem==YSpz3pwXw@mail.gmail.com>
Message-ID: <CAK8P3a31=gJkF+GypnaznfhKCYSnwU1yF4u0tem==YSpz3pwXw@mail.gmail.com>
Subject: Re: [PATCH] include: Remove pagemap.h from blkdev.h
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Provags-ID: V03:K1:OXnu0ucA1wyi7+lsio3wJ7anxEE+Dfl9WxSWkiji74vJmQV/e+z
 /UuE19runp+N+cWAwFxoNV/Oxqmy80PT6FRUX2/Qqm83lhmHvaDTABHTNEs98pkXpsofEST
 zJ6c0FPdemYuWeYyN4EVvC27hauj3JLuq1aYSBCN63RNjnReoBBn/nBMC5yBGdAc4meIF7e
 zLEbPd4YgzDiGisZXhMqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4cAS9hei4/U=:V6coH8Au1+F7SdZmUZCI2R
 /CvDSYC2NPktfWwYM6nrnwY9UampXaxfGBn3jE4gl/XpwW5PmFd1hfCQySoyGcizrkDr5j7wD
 fAceosamEm8lbg2wylPUYsYkKitaWJIH8hLSugV4bR/9F+Qft6hovYEIfuNImtk2hz6c66s8H
 mTyq66QehLFmQqPE5nWdPpk54sFK9obgBewLY+biKTdo25zHP140QEK3qCPkG6XTUku178f28
 tyuw6RHN47b4MhQQhziecSgqogC4JjRsVKvYsEVo+9HSVaEC1iqwOnWe56oaLdo4X12G5EtBd
 aRSOpKXL/elmAeCtWlv7p7AjLu1m8UzfdPvsNja0ghmlMloPWIAF2lzRuFxzaWS0N7B5VuUed
 +FoTi99O3vI//IwesK/i30Dql+C7RxF1cXGKw7BJv62MF0WFBOcvJf86Z018v
Message-ID-Hash: LY2MVZHORRYPXVFPE47TTPUBXKNDKLUX
X-Message-ID-Hash: LY2MVZHORRYPXVFPE47TTPUBXKNDKLUX
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-scsi <linux-scsi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LY2MVZHORRYPXVFPE47TTPUBXKNDKLUX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 9, 2021 at 7:15 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> My UEK-derived config has 1030 files depending on pagemap.h before
> this change.  Afterwards, just 240 files need to be rebuilt when I
> touch pagemap.h.  I think blkdev.h is probably included too widely,
> but untangling that dependency is harder and this solves my problem.
> x86 allmodconfig builds, but there may be implicit include problems
> on other architectures.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Good catch!

With the build regression fixed (I suppose you now need to include
pagemap.h in swap.h):

Acked-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
