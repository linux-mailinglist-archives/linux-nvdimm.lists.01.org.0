Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA0D55829
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Jun 2019 21:52:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5E46212A36CD;
	Tue, 25 Jun 2019 12:52:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CD85921295CB7
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 12:52:29 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z23so38286ote.13
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w0iye/3d1d43WiqVq+yINWIQnPqAw8A16FUwAjTLITU=;
 b=cg40kmVDe098Yeal1OpwCn3OtKBjzRnBRkGsDiRkJlBZmoYI19FP8EGzmZENBKS9gc
 y85l2sQkHTXgqXraL4kaAGyPSS89BlMic0a5IYD4ijt8AaGI5dAMpm1LqTsvqtZ0PA18
 /sFXK4G4VbfJsBTSuI7jnUNqry2IT3CR4rWFZDFAIwwgF0wpO56iBYn1OrWh8zMn5H5U
 UiXxOJDTdDUZ1sp/qT4gDr5qxfq60VgObAV3QcEkH8aWy3k9rRcTQ+1xwDIMTbjb/rOl
 vLBtj451wwdwT3Iv/y3LeY44bWSWgm5KwxP2Hkh4f45wvrSWUrzPcQdtg3gHbAGRQLJ3
 R1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w0iye/3d1d43WiqVq+yINWIQnPqAw8A16FUwAjTLITU=;
 b=CPECwU6Tx9ZFJkQIYfyyP9xQbVex27Imk3wdxBjgiu/aP0QeFefEP1ejDIqk5jrIUV
 K3K342s7Kvj9GvfbSCgZNDqrOn/12j64zHcwt8UMIZPxnHB5xJAHTTNLN9M/yCJzD8wC
 3Z1GHz9PxPxvpgRi6llb1PK6dZcu7OjiPlsmQpgFD4Cb0Q2ERG8cE9Z5Wwj7LNV65enB
 xfy9XnnCnXJ5CtGKU2m77SeQhKocaSAf2GaegPgjPzCYJ3lesjQ9ft1rw8wfWa/lKrHw
 LefqhhyeLg9BCo7WmGoOENrmGy6/V+xm+CjTiF82vM2YHbbj93MUjnESA577GlVJcPx2
 02lQ==
X-Gm-Message-State: APjAAAWfQbyG/Dlfgxs/j/+9c3uSRF9iktBc/CPuHNDeVYMOru7zH/xb
 grbxBQ1QfokuuT/yZACI8GjYWAOOCx6xIVhmfko4CA==
X-Google-Smtp-Source: APXvYqx9tkQWIJH6qfCTM4r93Fn0JkGxBFjGh9k1TjumYyf0PnXcUjYDBWeUS/klLXmbZuWZeGlEsSD0mVmlPe4JDBw=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr50775oto.207.1561492348979;
 Tue, 25 Jun 2019 12:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz>
 <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
 <20190625072317.GC30350@lst.de> <20190625150053.GJ11400@dhcp22.suse.cz>
 <CAPcyv4j1e5dbBHnc+wmtsNUyFbMK_98WxHNwuD_Vxo4dX9Ce=Q@mail.gmail.com>
 <20190625190038.GK11400@dhcp22.suse.cz>
In-Reply-To: <20190625190038.GK11400@dhcp22.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 25 Jun 2019 12:52:18 -0700
Message-ID: <CAPcyv4hU13v7dSQpF0WTQTxQM3L3UsHMUhsFMVz7i4UGLoM89g@mail.gmail.com>
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

On Tue, Jun 25, 2019 at 12:01 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 25-06-19 11:03:53, Dan Williams wrote:
> > On Tue, Jun 25, 2019 at 8:01 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Tue 25-06-19 09:23:17, Christoph Hellwig wrote:
> > > > On Mon, Jun 24, 2019 at 11:24:48AM -0700, Dan Williams wrote:
> > > > > I asked for this simply because it was not exported historically. In
> > > > > general I want to establish explicit export-type criteria so the
> > > > > community can spend less time debating when to use EXPORT_SYMBOL_GPL
> > > > > [1].
> > > > >
> > > > > The thought in this instance is that it is not historically exported
> > > > > to modules and it is safer from a maintenance perspective to start
> > > > > with GPL-only for new symbols in case we don't want to maintain that
> > > > > interface long-term for out-of-tree modules.
> > > > >
> > > > > Yes, we always reserve the right to remove / change interfaces
> > > > > regardless of the export type, but history has shown that external
> > > > > pressure to keep an interface stable (contrary to
> > > > > Documentation/process/stable-api-nonsense.rst) tends to be less for
> > > > > GPL-only exports.
> > > >
> > > > Fully agreed.  In the end the decision is with the MM maintainers,
> > > > though, although I'd prefer to keep it as in this series.
> > >
> > > I am sorry but I am not really convinced by the above reasoning wrt. to
> > > the allocator API and it has been a subject of many changes over time. I
> > > do not remember a single case where we would be bending the allocator
> > > API because of external modules and I am pretty sure we will push back
> > > heavily if that was the case in the future.
> >
> > This seems to say that you have no direct experience of dealing with
> > changing symbols that that a prominent out-of-tree module needs? GPU
> > drivers and the core-mm are on a path to increase their cooperation on
> > memory management mechanisms over time, and symbol export changes for
> > out-of-tree GPU drivers have been a significant source of friction in
> > the past.
>
> I have an experience e.g. to rework semantic of some gfp flags and that is
> something that users usualy get wrong and never heard that an out of
> tree code would insist on an old semantic and pushing us to the corner.
>
> > > So in this particular case I would go with consistency and export the
> > > same way we do with other functions. Also we do not want people to
> > > reinvent this API and screw that like we have seen in other cases when
> > > external modules try reimplement core functionality themselves.
> >
> > Consistency is a weak argument when the cost to the upstream community
> > is negligible. If the same functionality was available via another /
> > already exported interface *that* would be an argument to maintain the
> > existing export policy. "Consistency" in and of itself is not a
> > precedent we can use more widely in default export-type decisions.
> >
> > Effectively I'm arguing EXPORT_SYMBOL_GPL by default with a later
> > decision to drop the _GPL. Similar to how we are careful to mark sysfs
> > interfaces in Documentation/ABI/ that we are not fully committed to
> > maintaining over time, or are otherwise so new that there is not yet a
> > good read on whether they can be made permanent.
>
> Documentation/process/stable-api-nonsense.rst

That document has failed to preclude symbol export fights in the past
and there is a reasonable argument to try not to retract functionality
that had been previously exported regardless of that document.

> Really. If you want to play with GPL vs. EXPORT_SYMBOL else this is up
> to you but I do not see any technical argument to make this particular
> interface to the page allocator any different from all others that are
> exported to modules.

I'm failing to find any practical substance to your argument, but in
the end I agree with Chrishoph, it's up to MM maintainers.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
