Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B499257C53
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 08:41:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1892721962301;
	Wed, 26 Jun 2019 23:41:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Softfail (domain owner discourages use of this host)
 identity=mailfrom; client-ip=195.135.220.15; helo=mx1.suse.de;
 envelope-from=mhocko@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 437CC21297063
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 23:41:09 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4E3F7AFAE;
 Thu, 27 Jun 2019 06:41:07 +0000 (UTC)
Date: Thu, 27 Jun 2019 08:41:06 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
Message-ID: <20190627064106.GC17798@dhcp22.suse.cz>
References: <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz>
 <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
 <20190625072317.GC30350@lst.de>
 <20190625150053.GJ11400@dhcp22.suse.cz>
 <CAPcyv4j1e5dbBHnc+wmtsNUyFbMK_98WxHNwuD_Vxo4dX9Ce=Q@mail.gmail.com>
 <20190625190038.GK11400@dhcp22.suse.cz>
 <CAPcyv4hU13v7dSQpF0WTQTxQM3L3UsHMUhsFMVz7i4UGLoM89g@mail.gmail.com>
 <20190626054645.GB17798@dhcp22.suse.cz>
 <CAPcyv4jLK2F2UHqbwp4bCEiB7tL8sVsr775egKMmJvfZG+W+NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jLK2F2UHqbwp4bCEiB7tL8sVsr775egKMmJvfZG+W+NQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed 26-06-19 09:14:32, Dan Williams wrote:
> On Tue, Jun 25, 2019 at 10:46 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 25-06-19 12:52:18, Dan Williams wrote:
> > [...]
> > > > Documentation/process/stable-api-nonsense.rst
> > >
> > > That document has failed to preclude symbol export fights in the past
> > > and there is a reasonable argument to try not to retract functionality
> > > that had been previously exported regardless of that document.
> >
> > Can you point me to any specific example where this would be the case
> > for the core kernel symbols please?
> =

> The most recent example that comes to mind was the thrash around
> __kernel_fpu_{begin,end} [1].

Well, this seems more like a disagreement over a functionality that has
reduced its visibility rather than enforcement of a specific API. And I
do agree that the above document states that this is perfectly
legitimate and no out-of-tree code can rely on _any_ functionality to be
preserved.

On the other hand, I am not really surprised about the discussion
because d63e79b114c02 is a mere clean up not explaining why the
functionality should be restricted to GPL only code. So there certainly
is a room for clarification. Especially when the code has been exported
without this restriction in the past (see 8546c008924d5). So to me this
sounds more like a usual EXPORT_SYMBOL{_GPL} mess.

In any case I really do not see any relation to the maintenance cost
here. GPL symbols are not in any sense more stable than any other
exported symbol. They can change at any time. The only maintenance
burden is to update all _in_kernel_ users of the said symbol. Any
out-of-tree code is on its own to deal with this. Full stop.

GPL or non-GPL symbols are solely to define a scope of the usage.
Nothing less and nothing more.

> I referenced that when debating _GPL symbol policy with J=E9r=F4me [2].
> =

> [1]: https://lore.kernel.org/lkml/20190522100959.GA15390@kroah.com/
> [2]: https://lore.kernel.org/lkml/CAPcyv4gb+r=3D=3DriKFXkVZ7gGdnKe62yBmZ7=
xOa4uBBByhnK9Tzg@mail.gmail.com/

-- =

Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
