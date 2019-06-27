Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF57589FF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 20:30:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2E623212AB006;
	Thu, 27 Jun 2019 11:30:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0A486212966F3
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 11:30:05 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id x21so3268046otq.12
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7E3kE8wu6XArETAHziQvnZYV/Eha0av5p2dljNuncOs=;
 b=foFvp30DG07jcUeEQRk8SMFfwd/Wva8/DnhLRWyqOIEHY3iQ0bH3xBBjNEWt1UAb9i
 aSc3lqlBun4TcabEhTjxpZ+OkIyuycNXsXlxccJejQbd632UL5dTF0ReYx9tgjN1LZpK
 mBX/S+GBhEMY+hKQwLcUyojf3H+OPilbFg/JD2SVMM8M3MT8ZlLkX9kEa99YULT2J3wq
 SG/RSlHZrZLlAxovfeBCH2Ijpak7jmNP8mbWhWYFIOM4MtwTQ47fcYTztP21tUI+pIKW
 0YYfQqSutj9IcqcAXAchA74/rzypF+j+tEfioCqOTkayP1R9aOB5o1e55rrlVcQGp0yZ
 oBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7E3kE8wu6XArETAHziQvnZYV/Eha0av5p2dljNuncOs=;
 b=q5jyLtWM43nQI19V6I//k+xyD2Gv/2aQVyvP1Vimi3gvSauxine5SDZmnraLK1tX6o
 HYRS6QKsB47YlmD8BCghxDoqyXmjUowW6d23R3Bhbu7UAYPz+3yWoOfwKoPWosTvhmcm
 11MXf29vJDGUlhOhHexaZiS7RfB7XJ/R7FDihEXxD3X3mwL4ZAYAH9MiCqIr9gdtZp5H
 ORc9oznATgJOuhRq8gtJmwyKuLVNLaGtBsDaPZDRGBoQe9toxymqQ9NM8f4WrW6obEz0
 Z6Mw8BzYScw3KAnUheLJPk46Z33xsLpRjbot3+GSUZOF4V3bewtETsqA7xIbbsqaqCvR
 XJnA==
X-Gm-Message-State: APjAAAUoWylk+hqO+rtlGBeJD249bA8XvRfyH2w5bMJSjwXmP84fEJ7e
 S8tvVC+z+Xcx9FTrzBZ2GyNDPd/kf2slE85Kemk57g==
X-Google-Smtp-Source: APXvYqzR6jmVs33hZDIYobItCy5fbsq9anYEdod2Ip+FjFmtBNmx0NXxWd92xbXTibPcVqTURkcFzBgWlQkkEVlfzdE=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr4463320oto.207.1561660204791; 
 Thu, 27 Jun 2019 11:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190627123415.GA4286@bombadil.infradead.org>
 <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
In-Reply-To: <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 27 Jun 2019 11:29:53 -0700
Message-ID: <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
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

On Thu, Jun 27, 2019 at 9:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Jun 27, 2019 at 5:34 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Jun 26, 2019 at 05:15:45PM -0700, Dan Williams wrote:
> > > Ever since the conversion of DAX to the Xarray a RocksDB benchmark has
> > > been encountering intermittent lockups. The backtraces always include
> > > the filesystem-DAX PMD path, multi-order entries have been a source of
> > > bugs in the past, and disabling the PMD path allows a test that fails in
> > > minutes to run for an hour.
> >
> > On May 4th, I asked you:
> >
> > Since this is provoked by a fatal signal, it must have something to do
> > with a killable or interruptible sleep.  There's only one of those in the
> > DAX code; fatal_signal_pending() in dax_iomap_actor().  Does rocksdb do
> > I/O with write() or through a writable mmap()?  I'd like to know before
> > I chase too far down this fault tree analysis.
>
> RocksDB in this case is using write() for writes and mmap() for reads.

It's not clear to me that a fatal signal is a component of the failure
as much as it's the way to detect that the benchmark has indeed locked
up.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
