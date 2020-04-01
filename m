Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B345619B05D
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 18:26:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A86EE10FC3764;
	Wed,  1 Apr 2020 09:27:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9748010FC3764
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1585758409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j4AR5r17BWV2Q3tJVUOU56LC0f5zCeG7TGv0ZIShdr4=;
	b=EKKwcaWShwD6E+AIOX3mTPeTShFr7jSGTztUHyIilB/vtL0L5EuyRki8Vk9qGtGuDKqTpX
	8N/tx3XsKczq1z0j15EUKJg8eRLnRanvo7HkOThMFQbbGv4IL4OuOnrUAcr3AVKvP+Gp8U
	tg6u4Tc358gkVcnURFsqPFR6isjuh/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-vsVvsof0PX69idRJKXN5EA-1; Wed, 01 Apr 2020 12:26:48 -0400
X-MC-Unique: vsVvsof0PX69idRJKXN5EA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 648951005509;
	Wed,  1 Apr 2020 16:26:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2963D60C05;
	Wed,  1 Apr 2020 16:26:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 031GQghf007465;
	Wed, 1 Apr 2020 12:26:42 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 031GQfMp007461;
	Wed, 1 Apr 2020 12:26:42 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Wed, 1 Apr 2020 12:26:41 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] memcpy_flushcache: use cache flusing for larger
 lengths
In-Reply-To: <CAPcyv4ijR185RLmtT+A+WZxJs309qPfdqj5eUDEkMgFbxsV+uw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2004010941310.23210@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2003291625590.32108@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2003300729320.9938@file01.intranet.prod.int.rdu2.redhat.com> <CS1PR8401MB12377197482867F688BF93F7ABC80@CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM>
 <alpine.LRH.2.02.2003310709090.2117@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4ijR185RLmtT+A+WZxJs309qPfdqj5eUDEkMgFbxsV+uw@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: A3F5WXFDPNL6C63PQB4M55ULAXBQTTX4
X-Message-ID-Hash: A3F5WXFDPNL6C63PQB4M55ULAXBQTTX4
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Snitzer <msnitzer@redhat.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A3F5WXFDPNL6C63PQB4M55ULAXBQTTX4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 31 Mar 2020, Dan Williams wrote:

> > The benchmark shows that 64-byte non-temporal avx512 vmovntdq is as good
> > as 8, 16 or 32-bytes writes.
> >                                          ram            nvdimm
> > sequential write-nt 4 bytes              4.1 GB/s       1.3 GB/s
> > sequential write-nt 8 bytes              4.1 GB/s       1.3 GB/s
> > sequential write-nt 16 bytes (sse)       4.1 GB/s       1.3 GB/s
> > sequential write-nt 32 bytes (avx)       4.2 GB/s       1.3 GB/s
> > sequential write-nt 64 bytes (avx512)    4.1 GB/s       1.3 GB/s
> >
> > With cached writes (where each cache line is immediatelly followed by clwb
> > or clflushopt), 8, 16 or 32-byte write performs better than non-temporal
> > stores and avx512 performs worse.
> >
> > sequential write 8 + clwb                5.1 GB/s       1.6 GB/s
> > sequential write 16 (sse) + clwb         5.1 GB/s       1.6 GB/s
> > sequential write 32 (avx) + clwb         4.4 GB/s       1.5 GB/s
> > sequential write 64 (avx512) + clwb      1.7 GB/s       0.6 GB/s
> 
> This is indeed compelling straight-line data. My concern, similar to
> Robert's, is what it does to the rest of the system. In addition to
> increasing cache pollution, which I agree is difficult to quantify, it

I've made this program that measures cache pollution:
    http://people.redhat.com/~mpatocka/testcases/pmem/misc/l1-test.c
- it fills the L1 cache with random pointers, so that memory prediction 
won't help, and then walks these pointers before and after the task that 
we want to measure.

The results are:

on RAM, there is not much difference - i.e. nt write is flushing cache as 
much as clflushopt and clwb:
nt write:	8514 - 21034
clflushopt:	8516 - 21798
clwb:		8516 - 22882

But on PMEM, non-temporal stores perform much better and they perform 
	even better than on RAM:
nt write:	8514 - 11694
clflushopt:	8514 - 20816
clwb:		8514 - 21480

However, both dm-writecache and the nova filesystem perform better if we 
use cache flushing instead of nt writes:
  http://people.redhat.com/~mpatocka/testcases/pmem/benchmarks/fs-bench.txt

> may also increase read-for-ownership traffic. Could you collect 'perf
> stat' for this clwb vs nt comparison to check if any of this
> incidental overhead effect shows up in the numbers? Here is a 'perf
> stat' line that might capture that.
> 
> perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,L1-dcache-prefetch-misses,LLC-loads,LLC-load-misses,LLC-stores,LLC-store-misses,LLC-prefetch-misses
> -r 5 $benchmark
> 
> In both cases nt and explicit clwb there's nothing that prevents the
> dirty-cacheline, or the fill buffer from being written-back / flushed
> before the full line is populated and maybe you are hitting that
> scenario differently with the two approaches? I did not immediately
> see a perf counter for events like this. Going forward I think this
> gets better with the movdir64b instruction because that can guarantee
> full-line-sized store-buffer writes.
> 
> Maybe the perf data can help make a decision about whether we go with
> your patch in the near term?

These are results for 6 tests:
1. movntiq on pmem
2. 8 writes + clflushopt on pmem
3. 8 writes + clwb on pmem
4. movntiq on ram
5. 8 writes + clflushopt on ram
6. 8 writes + clwb on ram

perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,L1-dcache-prefetch-misses,LLC-loads,LLC-load-misses,LLC-stores,LLC-store-misses,LLC-prefetch-misses -r 5 ./thrp-write-nt-8 /dev/dax3.0
thr: 1.280840 GB/s, lat: 6.245904 nsec
thr: 1.281988 GB/s, lat: 6.240310 nsec
thr: 1.281000 GB/s, lat: 6.245120 nsec
thr: 1.278589 GB/s, lat: 6.256896 nsec
thr: 1.280094 GB/s, lat: 6.249541 nsec

 Performance counter stats for './thrp-write-nt-8 /dev/dax3.0' (5 runs):

         814899605      L1-dcache-loads                                               ( +-  0.04% )  (42.86%)
           8924277      L1-dcache-load-misses     #    1.10% of all L1-dcache hits    ( +-  0.19% )  (57.15%)
         810672184      L1-dcache-stores                                              ( +-  0.02% )  (57.15%)
   <not supported>      L1-dcache-store-misses
   <not supported>      L1-dcache-prefetch-misses
            100254      LLC-loads                                                     ( +-  9.58% )  (57.15%)
              6990      LLC-load-misses           #    6.97% of all LL-cache hits     ( +-  5.08% )  (57.14%)
             16509      LLC-stores                                                    ( +-  1.38% )  (28.57%)
              5070      LLC-store-misses                                              ( +-  3.28% )  (28.57%)
   <not supported>      LLC-prefetch-misses

           5.62889 +- 0.00357 seconds time elapsed  ( +-  0.06% )


perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,L1-dcache-prefetch-misses,LLC-loads,LLC-load-misses,LLC-stores,LLC-store-misses,LLC-prefetch-misses -r 5 ./thrp-write-8-clflushopt /dev/dax3.0
thr: 1.611084 GB/s, lat: 4.965600 nsec
thr: 1.598570 GB/s, lat: 5.004474 nsec
thr: 1.600563 GB/s, lat: 4.998243 nsec
thr: 1.596818 GB/s, lat: 5.009964 nsec
thr: 1.593989 GB/s, lat: 5.018856 nsec

 Performance counter stats for './thrp-write-8-clflushopt /dev/dax3.0' (5 runs):

         137415972      L1-dcache-loads                                               ( +-  1.28% )  (42.84%)
         136513938      L1-dcache-load-misses     #   99.34% of all L1-dcache hits    ( +-  1.24% )  (57.13%)
        1153397051      L1-dcache-stores                                              ( +-  1.29% )  (57.14%)
   <not supported>      L1-dcache-store-misses
   <not supported>      L1-dcache-prefetch-misses
            168100      LLC-loads                                                     ( +-  0.84% )  (57.15%)
              3975      LLC-load-misses           #    2.36% of all LL-cache hits     ( +-  2.41% )  (57.16%)
          58441682      LLC-stores                                                    ( +-  1.38% )  (28.57%)
              2493      LLC-store-misses                                              ( +-  6.80% )  (28.56%)
   <not supported>      LLC-prefetch-misses

            5.7029 +- 0.0582 seconds time elapsed  ( +-  1.02% )


perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,L1-dcache-prefetch-misses,LLC-loads,LLC-load-misses,LLC-stores,LLC-store-misses,LLC-prefetch-misses -r 5 ./thrp-write-8-clwb /dev/dax3.0
thr: 1.595520 GB/s, lat: 5.014039 nsec
thr: 1.598659 GB/s, lat: 5.004194 nsec
thr: 1.599901 GB/s, lat: 5.000309 nsec
thr: 1.603323 GB/s, lat: 4.989636 nsec
thr: 1.608657 GB/s, lat: 4.973093 nsec

 Performance counter stats for './thrp-write-8-clwb /dev/dax3.0' (5 runs):

         135421993      L1-dcache-loads                                               ( +-  0.06% )  (42.85%)
         134869685      L1-dcache-load-misses     #   99.59% of all L1-dcache hits    ( +-  0.02% )  (57.14%)
        1138042172      L1-dcache-stores                                              ( +-  0.02% )  (57.14%)
   <not supported>      L1-dcache-store-misses
   <not supported>      L1-dcache-prefetch-misses
            184600      LLC-loads                                                     ( +-  0.79% )  (57.15%)
              5756      LLC-load-misses           #    3.12% of all LL-cache hits     ( +-  5.23% )  (57.15%)
          55755196      LLC-stores                                                    ( +-  0.04% )  (28.57%)
              4928      LLC-store-misses                                              ( +-  4.19% )  (28.56%)
   <not supported>      LLC-prefetch-misses

           5.63954 +- 0.00987 seconds time elapsed  ( +-  0.18% )

perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,L1-dcache-prefetch-misses,LLC-loads,LLC-load-misses,LLC-stores,LLC-store-misses,LLC-prefetch-misses -r 5 ./thrp-write-nt-8 /dev/ram0
thr: 4.156424 GB/s, lat: 1.924732 nsec
thr: 4.156363 GB/s, lat: 1.924760 nsec
thr: 4.159350 GB/s, lat: 1.923377 nsec
thr: 4.162535 GB/s, lat: 1.921906 nsec
thr: 4.158470 GB/s, lat: 1.923784 nsec

 Performance counter stats for './thrp-write-nt-8 /dev/ram0' (5 runs):

        3077534777      L1-dcache-loads                                               ( +-  0.14% )  (42.85%)
          49870893      L1-dcache-load-misses     #    1.62% of all L1-dcache hits    ( +-  0.82% )  (57.14%)
        2854270644      L1-dcache-stores                                              ( +-  0.01% )  (57.14%)
   <not supported>      L1-dcache-store-misses
   <not supported>      L1-dcache-prefetch-misses
           5391862      LLC-loads                                                     ( +-  0.29% )  (57.15%)
           5190166      LLC-load-misses           #   96.26% of all LL-cache hits     ( +-  0.23% )  (57.15%)
           5694448      LLC-stores                                                    ( +-  0.39% )  (28.57%)
           5544968      LLC-store-misses                                              ( +-  0.37% )  (28.56%)
   <not supported>      LLC-prefetch-misses

           5.61044 +- 0.00145 seconds time elapsed  ( +-  0.03% )


perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,L1-dcache-prefetch-misses,LLC-loads,LLC-load-misses,LLC-stores,LLC-store-misses,LLC-prefetch-misses -r 5 ./thrp-write-8-clflushopt /dev/ram0
thr: 5.923164 GB/s, lat: 1.350629 nsec
thr: 5.922262 GB/s, lat: 1.350835 nsec
thr: 5.921674 GB/s, lat: 1.350969 nsec
thr: 5.922305 GB/s, lat: 1.350825 nsec
thr: 5.921393 GB/s, lat: 1.351033 nsec

 Performance counter stats for './thrp-write-8-clflushopt /dev/ram0' (5 runs):

         935965584      L1-dcache-loads                                               ( +-  0.34% )  (42.85%)
         521443969      L1-dcache-load-misses     #   55.71% of all L1-dcache hits    ( +-  0.05% )  (57.15%)
        4460590261      L1-dcache-stores                                              ( +-  0.01% )  (57.15%)
   <not supported>      L1-dcache-store-misses
   <not supported>      L1-dcache-prefetch-misses
           6242393      LLC-loads                                                     ( +-  0.32% )  (57.15%)
           5727982      LLC-load-misses           #   91.76% of all LL-cache hits     ( +-  0.27% )  (57.15%)
          54576336      LLC-stores                                                    ( +-  0.05% )  (28.57%)
          54056225      LLC-store-misses                                              ( +-  0.04% )  (28.57%)
   <not supported>      LLC-prefetch-misses

           5.79196 +- 0.00105 seconds time elapsed  ( +-  0.02% )


perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,L1-dcache-prefetch-misses,LLC-loads,LLC-load-misses,LLC-stores,LLC-store-misses,LLC-prefetch-misses -r 5 ./thrp-write-8-clwb /dev/ram0
thr: 5.821923 GB/s, lat: 1.374116 nsec
thr: 5.818980 GB/s, lat: 1.374811 nsec
thr: 5.821207 GB/s, lat: 1.374285 nsec
thr: 5.818583 GB/s, lat: 1.374905 nsec
thr: 5.820813 GB/s, lat: 1.374379 nsec

 Performance counter stats for './thrp-write-8-clwb /dev/ram0' (5 runs):

         951910720      L1-dcache-loads                                               ( +-  0.31% )  (42.84%)
         512771268      L1-dcache-load-misses     #   53.87% of all L1-dcache hits    ( +-  0.03% )  (57.13%)
        4390478387      L1-dcache-stores                                              ( +-  0.02% )  (57.15%)
   <not supported>      L1-dcache-store-misses
   <not supported>      L1-dcache-prefetch-misses
           5614628      LLC-loads                                                     ( +-  0.24% )  (57.16%)
           5200663      LLC-load-misses           #   92.63% of all LL-cache hits     ( +-  0.09% )  (57.16%)
          52627554      LLC-stores                                                    ( +-  0.10% )  (28.56%)
          52108200      LLC-store-misses                                              ( +-  0.16% )  (28.55%)
   <not supported>      LLC-prefetch-misses

          5.646728 +- 0.000438 seconds time elapsed  ( +-  0.01% )




> > > In user space, glibc faces similar choices for its memcpy() functions;
> > > glibc memcpy() uses non-temporal stores for transfers > 75% of the
> > > L3 cache size divided by the number of cores. For example, with
> > > glibc-2.216-16.fc27 (August 2017), on a Broadwell system with
> > > E5-2699 36 cores 45 MiB L3 cache, non-temporal stores are used
> > > for memcpy()s over 36 MiB.
> >
> > BTW. what does glibc do with reads? Does it flush them from the cache
> > after they are consumed?
> >
> > AFAIK glibc doesn't support persistent memory - i.e. there is no function
> > that flushes data and the user has to use inline assembly for that.
> 
> Yes, and I don't know of any copy routines that try to limit the cache
> pollution of pulling the source data for a copy, only the destination.
> 
> > > It'd be nice if glibc, PMDK, and the kernel used the same algorithms.
> 
> Yes, it would. Although I think PMDK would make a different decision
> than the kernel when optimizing for highest bandwidth for the local
> application vs bandwidth efficiency across all applications.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
