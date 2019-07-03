Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9245D968
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 02:42:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57612212AC489;
	Tue,  2 Jul 2019 17:42:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 973E621A09130
 for <linux-nvdimm@lists.01.org>; Tue,  2 Jul 2019 17:42:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n5so519935otk.1
 for <linux-nvdimm@lists.01.org>; Tue, 02 Jul 2019 17:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0AGSyMvf0zexOMokX4EpC11/R6d7poyoJeo3TShyztM=;
 b=QWyJjuDYJNyB44jlcWkT2Do84tRKoTgiiRWbe8c+iRWLpEQXaFEgT0w9ZSZH2Cs9Tf
 NgpgZ8pPPSpSGIZa0MJeB+dtoragQ2H4oPc7bonqaiiNZhCo2ZOJ7wWuogIDhfx9e4s/
 ZfZgI41C2VLSea49134z094gXVVtjlcxZP9bHzuIY6XmQJlEzTwh4QKqYp1GvIhzTBqP
 C0rfgeI6tqW1a8lFZkStsJB+FEkRAIaU3kaEYBQPQGtfGa8CabE6/0FtfDI1lC7Xc0F+
 6+LCGjufHIildbzfwK5DH2jwZiLcBGxTCOHmP+FN42+bD0bPJuwOEVfltIw786Xw5ebf
 Gk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0AGSyMvf0zexOMokX4EpC11/R6d7poyoJeo3TShyztM=;
 b=k5FTzci+ohKyWSXY4qOoathzNY6JDEF1thg/kKQ7yYWMfJhgnHB0Kv9yY6lDKjzDps
 rfDZZKO2FrTXVcdZqbS8tMJE7l5l6V4K9m84cr5mB+tDmE+dSUSoObcXCeSRa7wYTgld
 Gsh8tuSSlzCw1VBKP64petYgjKIrDRp5Q7TVUE1ZXsgSpUloRpcqyOqgSDtO57Emyc7Y
 2obNewDWKnyFGv4W8kv5qSKZvDkpMcxqg6N4hP5HaDs0eYG2jXZQAYZshwLC18O5XkC8
 2Lb+CtbbvlSZCofe9z9Q4OcKwrpp55/w12uK/rpfWSY4B8fuzBUPK3F0NQZi6KnfBjLf
 2Pag==
X-Gm-Message-State: APjAAAUV0471vY9HjTQGsQ45C3V+zLIeJ/L4q5jhZFe6GWjeNdmm+dHY
 3yrDwBO5+inV4MHoWXzdBDnGaDKNzsEehxk19DxzOg==
X-Google-Smtp-Source: APXvYqwt/AruSNRNxTjRUQk6hQeRuA06O8pI4+Ci7eZfCus0eFiY7ywxyleud1COJr+2irFyLNDBtxvmvCpYM8UHPzM=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr25111745otn.247.1562114560450; 
 Tue, 02 Jul 2019 17:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org>
 <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
 <20190629160336.GB1180@bombadil.infradead.org>
 <CAPcyv4ge3Ht1k_v=tSoVA6hCzKg1N3imhs_rTL3oTB+5_KC8_Q@mail.gmail.com>
 <CAA9_cmcb-Prn6CnOx-mJfb9CRdf0uG9u4M1Vq1B1rKVemCD-Vw@mail.gmail.com>
 <20190630152324.GA15900@bombadil.infradead.org>
 <CAPcyv4j2NBPBEUU3UW1Q5OyOEuo9R5e90HpkowpeEkMsAKiUyQ@mail.gmail.com>
 <20190702033410.GB1729@bombadil.infradead.org>
 <CAPcyv4iEkN1o5HD6Gb9m5ohdAVQhmtiTDcFE+PMQczYx635Vwg@mail.gmail.com>
 <fa9b9165-7910-1fbd-fb5b-78023936d2f2@gmail.com>
In-Reply-To: <fa9b9165-7910-1fbd-fb5b-78023936d2f2@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 2 Jul 2019 17:42:28 -0700
Message-ID: <CAPcyv4ihQ9djQvgnqZoTLRH3CwFhpWK_uUrmWSLH_3-Fi1g1qw@mail.gmail.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
To: Boaz Harrosh <openosd@gmail.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Seema Pandit <seema.pandit@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jul 2, 2019 at 5:23 PM Boaz Harrosh <openosd@gmail.com> wrote:
>
> On 02/07/2019 18:37, Dan Williams wrote:
> <>
> >
> > I'd be inclined to do the brute force fix of not trying to get fancy
> > with separate PTE/PMD waitqueues and then follow on with a more clever
> > performance enhancement later. Thoughts about that?
> >
>
> Sir Dan
>
> I do not understand how separate waitqueues are any performance enhancement?
> The all point of the waitqueues is that there is enough of them and the hash
> function does a good radomization spread to effectively grab a single locker
> per waitqueue unless the system is very contended and waitqueues are shared.

Right, the fix in question limits the input to the hash calculation by
masking the input to always be 2MB aligned.

> Which is good because it means you effectively need a back pressure to the app.
> (Because pmem IO is mostly CPU bound with no long term sleeps I do not think
>  you will ever get to that situation)
>
> So the way I understand it having twice as many waitqueues serving two types
> will be better performance over all then, segregating the types each with half
> the number of queues.

Yes, but the trick is how to manage cases where someone waiting on one
type needs to be woken up by an event on the other. So all I'm saying
it lets live with more hash collisions until we can figure out a race
free way to better scale waitqueue usage.

>
> (Regardless of the above problem of where the segregation is not race clean)
>
> Thanks
> Boaz
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
