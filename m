Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC57556B6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Jun 2019 20:04:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B11C2129F038;
	Tue, 25 Jun 2019 11:04:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DEB6E212108D3
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 11:04:06 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id g7so13243608oia.8
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v+ZhBSNWMG71/hoVLbHT+wkJMxkbtm8D8gJnUatkLjU=;
 b=JxNg8q13dPoy4++bWTLKe91YyHwlNjFnbzSb9Om/uZZjmzDhnDweJK+SXVAHxvQJR0
 312VGhMneNMNXAmSV6hMRZIzT4bIOEkHXQoVC3M4u9DoF+fAlTSvPDyjEiVH1eTZKAv6
 dp2nCpruoX6QC/iIKdTTjv2kOKKIAnLDyxY0m5z6y8S0clG2ID2Kd3dCyQI6rh541kFT
 eDdVfoEDrUI7YN4BuqjchbcpiBzhNte5u19MgaVZHdA1NCRepz4PjjVsuhg3X5n+bs85
 X+HfBTjHRFVQoAtJFMiji2LpwQIjXK1seUAZDPl9j1P4iwnhlcEX3jRF05VVFomoae2Q
 6U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v+ZhBSNWMG71/hoVLbHT+wkJMxkbtm8D8gJnUatkLjU=;
 b=fhjFYn1FJUVruwnvmBdqbyd9gdJOd5b9rAblE79Oybnjn54C4NuCZQplMEYnfQvFWC
 n/WzdzeD+nik9uyLm2fI6jIm1eQvCMm8GY51rIQGgx4jUqH1BQ6ecCO0gCl7+/L79VAf
 ocNh6Ycz6IXdVYtTNXf6kxkj7lBeIU6ZRUAmpH/rEpNiWYNykRbZkwnCk9ml2kpzQtPg
 2o7uHLkKUqc/9nAZPrU9cfDaOpTI8gAzjXlJQCPpz2ZLD+sW440uw+55rtMybHSrz+CC
 sh6Xi3o5wfFTIgtQdi7GvpyiYrGepLhz5V+fS4a7CPMRooTUDgwU7bfJLE9sqPTvoDAq
 l3jA==
X-Gm-Message-State: APjAAAWtkacazcNM/fGx9UDXthd2WMpZ5/A4oyyB8jd1ldJ75ANPhYwA
 xJXK9Z2nsr/JEku5seEINQ21VTzYzzIBc0LWJVmRaQ==
X-Google-Smtp-Source: APXvYqz6T9TVXWGjVm88Qsyic/J7sZ8rY/3bbGIhMBzOCJnst1XOiiw6CA8iBdJBDNkwj6/NRoOe4+QnfOGQ8i6wx08=
X-Received: by 2002:aca:d60c:: with SMTP id n12mr15532591oig.105.1561485845899; 
 Tue, 25 Jun 2019 11:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz>
 <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
 <20190625072317.GC30350@lst.de> <20190625150053.GJ11400@dhcp22.suse.cz>
In-Reply-To: <20190625150053.GJ11400@dhcp22.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 25 Jun 2019 11:03:53 -0700
Message-ID: <CAPcyv4j1e5dbBHnc+wmtsNUyFbMK_98WxHNwuD_Vxo4dX9Ce=Q@mail.gmail.com>
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
To: Michal Hocko <mhocko@kernel.org>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, nouveau@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jun 25, 2019 at 8:01 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 25-06-19 09:23:17, Christoph Hellwig wrote:
> > On Mon, Jun 24, 2019 at 11:24:48AM -0700, Dan Williams wrote:
> > > I asked for this simply because it was not exported historically. In
> > > general I want to establish explicit export-type criteria so the
> > > community can spend less time debating when to use EXPORT_SYMBOL_GPL
> > > [1].
> > >
> > > The thought in this instance is that it is not historically exported
> > > to modules and it is safer from a maintenance perspective to start
> > > with GPL-only for new symbols in case we don't want to maintain that
> > > interface long-term for out-of-tree modules.
> > >
> > > Yes, we always reserve the right to remove / change interfaces
> > > regardless of the export type, but history has shown that external
> > > pressure to keep an interface stable (contrary to
> > > Documentation/process/stable-api-nonsense.rst) tends to be less for
> > > GPL-only exports.
> >
> > Fully agreed.  In the end the decision is with the MM maintainers,
> > though, although I'd prefer to keep it as in this series.
>
> I am sorry but I am not really convinced by the above reasoning wrt. to
> the allocator API and it has been a subject of many changes over time. I
> do not remember a single case where we would be bending the allocator
> API because of external modules and I am pretty sure we will push back
> heavily if that was the case in the future.

This seems to say that you have no direct experience of dealing with
changing symbols that that a prominent out-of-tree module needs? GPU
drivers and the core-mm are on a path to increase their cooperation on
memory management mechanisms over time, and symbol export changes for
out-of-tree GPU drivers have been a significant source of friction in
the past.

> So in this particular case I would go with consistency and export the
> same way we do with other functions. Also we do not want people to
> reinvent this API and screw that like we have seen in other cases when
> external modules try reimplement core functionality themselves.

Consistency is a weak argument when the cost to the upstream community
is negligible. If the same functionality was available via another /
already exported interface *that* would be an argument to maintain the
existing export policy. "Consistency" in and of itself is not a
precedent we can use more widely in default export-type decisions.

Effectively I'm arguing EXPORT_SYMBOL_GPL by default with a later
decision to drop the _GPL. Similar to how we are careful to mark sysfs
interfaces in Documentation/ABI/ that we are not fully committed to
maintaining over time, or are otherwise so new that there is not yet a
good read on whether they can be made permanent.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
