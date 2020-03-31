Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607A19A097
	for <lists+linux-nvdimm@lfdr.de>; Tue, 31 Mar 2020 23:19:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4127110FC36EA;
	Tue, 31 Mar 2020 14:20:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2760110FC3635
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 14:20:34 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id v1so27030394edq.8
        for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyTO6009JTCfLd3UlfmmxMzroAfVBiq2wFtDZniOPoA=;
        b=gbUvCPWpTriQ8JHR5BxWvl+KYugoDEUDTX2hJiCCBDgiZUE0ATCo//xiJyGPU8R8OD
         FcKDYZchRH1ODRx3qEwcsQaJPYXbB5tpRl1A2HL5KTGTv/m0sxp12TTeoCCVHBXysSkx
         qn6KAN6urppZpJ8vU+epdSmVXOKoseFDYAv1OQipfovxYpXFMmUju27RoIUCbFGFLZ/A
         FFK9eEmr3Gs7vBD0GD2TihdoCmbLkeoF7Kt2Fo4d0Uc0wYw4uPcpkjfKwiBWoZ4owWv8
         MC9YqtFh2L8Kj2hP8p2X4f6EpHoS9v0cqT/bs2dZIRR6CEad2pDEJaXmcmvbIjZt4nSZ
         sR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyTO6009JTCfLd3UlfmmxMzroAfVBiq2wFtDZniOPoA=;
        b=Hm+lrjdzPrR4wJGcgF/sOgeG5ZAUWbR5Jxi+THs++Dl8XIABNTRnZNoKoE7BMGTNGN
         Wg3/3Y0xGVGoSlwW/WgMoLt6CNpCdSM5WmhD5YMvyg91pG3wV2C0nedYWzzNQ+eNXu0m
         XTxTPIXKKUKPxOV4GTbTdSYAGG/39wq11Bw2XItUxDvg/uZbz+8UkjTGIK2f5lq8jqxr
         D88gjh2TNS5mZwBewK/PCWvpKz100u++G+y9VAFy7FZWWcN5mjDZYaefI1GTVcF9d+t0
         xqQUAdvs6wdijvN+Na+ac2NMLVb3iIj3kP0TbGQVRBN76cU/SJ0v+L0F5IVGJsFEzrJa
         uOIA==
X-Gm-Message-State: ANhLgQ2MPG0/uvJMKMRys5DAqUKrl1kqIJk2EuFpw1pHKvxmHnhjJH/s
	Ed8FVN8+P8TM4dVxmNnG/nhFh4wXMeCYxeDeacOoCA==
X-Google-Smtp-Source: ADFU+vtABgQXb+2PEWx0hDcyeb3463r13Md1qzkMGG01QQesWZLScUbpHISBuKxebdal1y7UNBfkFGiG0aFoj641FX8=
X-Received: by 2002:a50:d847:: with SMTP id v7mr17832750edj.154.1585689583161;
 Tue, 31 Mar 2020 14:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2003291625590.32108@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2003300729320.9938@file01.intranet.prod.int.rdu2.redhat.com>
 <CS1PR8401MB12377197482867F688BF93F7ABC80@CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM>
 <alpine.LRH.2.02.2003310709090.2117@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2003310709090.2117@file01.intranet.prod.int.rdu2.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2020 14:19:32 -0700
Message-ID: <CAPcyv4ijR185RLmtT+A+WZxJs309qPfdqj5eUDEkMgFbxsV+uw@mail.gmail.com>
Subject: Re: [PATCH v2] memcpy_flushcache: use cache flusing for larger lengths
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID-Hash: JT3WEH7PYTGC6CTHT35QGXPUBNCNLUO3
X-Message-ID-Hash: JT3WEH7PYTGC6CTHT35QGXPUBNCNLUO3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mike Snitzer <msnitzer@redhat.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JT3WEH7PYTGC6CTHT35QGXPUBNCNLUO3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ add x86 and LKML ]

On Tue, Mar 31, 2020 at 5:27 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Tue, 31 Mar 2020, Elliott, Robert (Servers) wrote:
>
> >
> >
> > > -----Original Message-----
> > > From: Mikulas Patocka <mpatocka@redhat.com>
> > > Sent: Monday, March 30, 2020 6:32 AM
> > > To: Dan Williams <dan.j.williams@intel.com>; Vishal Verma
> > > <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Ira
> > > Weiny <ira.weiny@intel.com>; Mike Snitzer <msnitzer@redhat.com>
> > > Cc: linux-nvdimm@lists.01.org; dm-devel@redhat.com
> > > Subject: [PATCH v2] memcpy_flushcache: use cache flusing for larger
> > > lengths
> > >
> > > I tested dm-writecache performance on a machine with Optane nvdimm
> > > and it turned out that for larger writes, cached stores + cache
> > > flushing perform better than non-temporal stores. This is the
> > > throughput of dm- writecache measured with this command:
> > > dd if=/dev/zero of=/dev/mapper/wc bs=64 oflag=direct
> > >
> > > block size  512             1024            2048            4096
> > > movnti      496 MB/s        642 MB/s        725 MB/s        744 MB/s
> > > clflushopt  373 MB/s        688 MB/s        1.1 GB/s        1.2 GB/s
> > >
> > > We can see that for smaller block, movnti performs better, but for
> > > larger blocks, clflushopt has better performance.
> >
> > There are other interactions to consider... see threads from the last
> > few years on the linux-nvdimm list.
>
> dm-writecache is the only linux driver that uses memcpy_flushcache on
> persistent memory. There is also the btt driver, it uses the "do_io"
> method to write to persistent memory and I don't know where this method
> comes from.
>
> Anyway, if patching memcpy_flushcache conflicts with something else, we
> should introduce memcpy_flushcache_to_pmem.
>
> > For example, software generally expects that read()s take a long time and
> > avoids re-reading from disk; the normal pattern is to hold the data in
> > memory and read it from there. By using normal stores, CPU caches end up
> > holding a bunch of persistent memory data that is probably not going to
> > be read again any time soon, bumping out more useful data. In contrast,
> > movnti avoids filling the CPU caches.
>
> But if I write one cacheline and flush it immediatelly, it would consume
> just one associative entry in the cache.
>
> > Another option is the AVX vmovntdq instruction (if available), the
> > most recent of which does 64-byte (cache line) sized transfers to
> > zmm registers. There's a hefty context switching overhead (e.g.,
> > 304 clocks), and the CPU often runs AVX instructions at a slower
> > clock frequency, so it's hard to judge when it's worthwhile.
>
> The benchmark shows that 64-byte non-temporal avx512 vmovntdq is as good
> as 8, 16 or 32-bytes writes.
>                                          ram            nvdimm
> sequential write-nt 4 bytes              4.1 GB/s       1.3 GB/s
> sequential write-nt 8 bytes              4.1 GB/s       1.3 GB/s
> sequential write-nt 16 bytes (sse)       4.1 GB/s       1.3 GB/s
> sequential write-nt 32 bytes (avx)       4.2 GB/s       1.3 GB/s
> sequential write-nt 64 bytes (avx512)    4.1 GB/s       1.3 GB/s
>
> With cached writes (where each cache line is immediatelly followed by clwb
> or clflushopt), 8, 16 or 32-byte write performs better than non-temporal
> stores and avx512 performs worse.
>
> sequential write 8 + clwb                5.1 GB/s       1.6 GB/s
> sequential write 16 (sse) + clwb         5.1 GB/s       1.6 GB/s
> sequential write 32 (avx) + clwb         4.4 GB/s       1.5 GB/s
> sequential write 64 (avx512) + clwb      1.7 GB/s       0.6 GB/s

This is indeed compelling straight-line data. My concern, similar to
Robert's, is what it does to the rest of the system. In addition to
increasing cache pollution, which I agree is difficult to quantify, it
may also increase read-for-ownership traffic. Could you collect 'perf
stat' for this clwb vs nt comparison to check if any of this
incidental overhead effect shows up in the numbers? Here is a 'perf
stat' line that might capture that.

perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,L1-dcache-prefetch-misses,LLC-loads,LLC-load-misses,LLC-stores,LLC-store-misses,LLC-prefetch-misses
-r 5 $benchmark

In both cases nt and explicit clwb there's nothing that prevents the
dirty-cacheline, or the fill buffer from being written-back / flushed
before the full line is populated and maybe you are hitting that
scenario differently with the two approaches? I did not immediately
see a perf counter for events like this. Going forward I think this
gets better with the movdir64b instruction because that can guarantee
full-line-sized store-buffer writes.

Maybe the perf data can help make a decision about whether we go with
your patch in the near term?

>
>
> > In user space, glibc faces similar choices for its memcpy() functions;
> > glibc memcpy() uses non-temporal stores for transfers > 75% of the
> > L3 cache size divided by the number of cores. For example, with
> > glibc-2.216-16.fc27 (August 2017), on a Broadwell system with
> > E5-2699 36 cores 45 MiB L3 cache, non-temporal stores are used
> > for memcpy()s over 36 MiB.
>
> BTW. what does glibc do with reads? Does it flush them from the cache
> after they are consumed?
>
> AFAIK glibc doesn't support persistent memory - i.e. there is no function
> that flushes data and the user has to use inline assembly for that.

Yes, and I don't know of any copy routines that try to limit the cache
pollution of pulling the source data for a copy, only the destination.

> > It'd be nice if glibc, PMDK, and the kernel used the same algorithms.

Yes, it would. Although I think PMDK would make a different decision
than the kernel when optimizing for highest bandwidth for the local
application vs bandwidth efficiency across all applications.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
