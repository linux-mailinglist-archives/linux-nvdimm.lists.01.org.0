Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8059586A5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 18:06:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 36047212AAB9F;
	Thu, 27 Jun 2019 09:06:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C5686212966E1
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 09:06:29 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w196so1967190oie.7
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aWIMvxomigHpjWeHK43P8bQp7hskbPyoEW4qUC++xwQ=;
 b=vp6g94SZAEhogB8+kASBrS83edW6InCqKko2xuhZZT36olRb9uNCLMVjLyfI6OQkYT
 8otOEjJ/wDda0iFu+AgKq5gR4ZQdNDsgl1cId5NnnL1iJ/GvZXT6HuisMcGOClqUlIDC
 FjGSCO8bQLXY3sOuHvTq/VDGJlZgYzKRP7eKLh/seOIB2ogk0e13lnG4EjwF37n71ps/
 zar5oshbh8IZ1AxD5brAYSbwVO6BQCN0DWQqcd2Fb8iQvPW8X62BL2WBnTS1MxzZQhxg
 ei8ENh0k8ProSrH8xiIDZSOUsBqFhCE5qcGcZDbva8PLP4urG/BUAIMh00/WAaoWm7Us
 XyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aWIMvxomigHpjWeHK43P8bQp7hskbPyoEW4qUC++xwQ=;
 b=FN3+ti9+tmn9f6+DELv82bMUczhrgk0iHSQp85VmjsEUHcOpV6r/g+Xlb1u60AHN3y
 HxlxhTlShoEARq1ZWYO3G/n0tJZ1yYlrNSi/EowBzsKxLnTcYPTHQo81KULZk/J4sZoh
 aiZSfMwWTwfYtdf2B6D1TWzm7hWWdqrDtGUvtHZ+VmsTCUEsY6GnFjWHDEdFtDQ+RUYA
 /ULGxCd8s+8zrlxj9wKu86nErQ7gBOSD6Lt1kDNPvSYG1wAU9taMrUc/2ouMC4BYZtEa
 VQxjc2WdQrA6TxNJGovpbyw/jAeoTevO4YlsieNQwI0ZYGXlGnEAu+V4higYpiukiCYf
 qGOQ==
X-Gm-Message-State: APjAAAU06IV3qQKoe3vGVFdkd0ZZM4gBRo3scldvhA8SIO3wv1QYqln/
 +zV8lZRW8b61aEi9TsnVUbhRP94lc4JDrRGKUrU6ag==
X-Google-Smtp-Source: APXvYqxTBH4M/fPCrgDrZ+VdGZm5oRMIwhu+eQ9E/gvhgkhPtescyRRgvt8+s9jNs39vk0crvfXTrVskZyRmmvNYxVA=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr2695751oii.0.1561651588356;
 Thu, 27 Jun 2019 09:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190627123415.GA4286@bombadil.infradead.org>
In-Reply-To: <20190627123415.GA4286@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 27 Jun 2019 09:06:17 -0700
Message-ID: <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
To: Matthew Wilcox <willy@infradead.org>
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
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 27, 2019 at 5:34 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jun 26, 2019 at 05:15:45PM -0700, Dan Williams wrote:
> > Ever since the conversion of DAX to the Xarray a RocksDB benchmark has
> > been encountering intermittent lockups. The backtraces always include
> > the filesystem-DAX PMD path, multi-order entries have been a source of
> > bugs in the past, and disabling the PMD path allows a test that fails in
> > minutes to run for an hour.
>
> On May 4th, I asked you:
>
> Since this is provoked by a fatal signal, it must have something to do
> with a killable or interruptible sleep.  There's only one of those in the
> DAX code; fatal_signal_pending() in dax_iomap_actor().  Does rocksdb do
> I/O with write() or through a writable mmap()?  I'd like to know before
> I chase too far down this fault tree analysis.

RocksDB in this case is using write() for writes and mmap() for reads.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
