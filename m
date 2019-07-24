Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE947287E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jul 2019 08:49:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 426B3212D2776;
	Tue, 23 Jul 2019 23:51:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=114.179.232.162; helo=tyo162.gate.nec.co.jp;
 envelope-from=n-horiguchi@ah.jp.nec.com; receiver=linux-nvdimm@lists.01.org 
Received: from tyo162.gate.nec.co.jp (tyo162.gate.nec.co.jp [114.179.232.162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A760621295B07
 for <linux-nvdimm@lists.01.org>; Tue, 23 Jul 2019 23:51:49 -0700 (PDT)
Received: from mailgate02.nec.co.jp ([114.179.233.122])
 by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x6O6nG5d021120
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Jul 2019 15:49:16 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x6O6nGFx009426;
 Wed, 24 Jul 2019 15:49:16 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x6O6dSsL017998; 
 Wed, 24 Jul 2019 15:49:16 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by
 mail03.kamome.nec.co.jp with ESMTP id BT-MMP-2404595;
 Wed, 24 Jul 2019 15:48:55 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0439.000; Wed,
 24 Jul 2019 15:48:55 +0900
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Jane Chu <jane.chu@oracle.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/memory-failure: Poison read receives SIGKILL instead
 of SIGBUS if mmaped more than once
Thread-Topic: [PATCH] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS if mmaped more than once
Thread-Index: AQHVQbAJYBnoCgkSO0yo1OfL2uazvqbYZaaAgABXyAA=
Date: Wed, 24 Jul 2019 06:48:54 +0000
Message-ID: <20190724064846.GA17567@hori.linux.bs1.fc.nec.co.jp>
References: <1563925110-19359-1-git-send-email-jane.chu@oracle.com>
 <CAPcyv4hyvHFnSE4AUbXooxX_Ug-raxAJgzC7jzkHp_mSg_sCmg@mail.gmail.com>
In-Reply-To: <CAPcyv4hyvHFnSE4AUbXooxX_Ug-raxAJgzC7jzkHp_mSg_sCmg@mail.gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-ID: <A8D19D1E94905D479DFEEA8EADF01457@gisp.nec.co.jp>
MIME-Version: 1.0
X-TM-AS-MML: disable
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
Cc: Linux MM <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Jane, Dan,

On Tue, Jul 23, 2019 at 06:34:35PM -0700, Dan Williams wrote:
> On Tue, Jul 23, 2019 at 4:49 PM Jane Chu <jane.chu@oracle.com> wrote:
> >
> > Mmap /dev/dax more than once, then read the poison location using address
> > from one of the mappings. The other mappings due to not having the page
> > mapped in will cause SIGKILLs delivered to the process. SIGKILL succeeds
> > over SIGBUS, so user process looses the opportunity to handle the UE.
> >
> > Although one may add MAP_POPULATE to mmap(2) to work around the issue,
> > MAP_POPULATE makes mapping 128GB of pmem several magnitudes slower, so
> > isn't always an option.
> >
> > Details -
> >
> > ndctl inject-error --block=10 --count=1 namespace6.0
> >
> > ./read_poison -x dax6.0 -o 5120 -m 2
> > mmaped address 0x7f5bb6600000
> > mmaped address 0x7f3cf3600000
> > doing local read at address 0x7f3cf3601400
> > Killed
> >
> > Console messages in instrumented kernel -
> >
> > mce: Uncorrected hardware memory error in user-access at edbe201400
> > Memory failure: tk->addr = 7f5bb6601000
> > Memory failure: address edbe201: call dev_pagemap_mapping_shift
> > dev_pagemap_mapping_shift: page edbe201: no PUD
> > Memory failure: tk->size_shift == 0
> > Memory failure: Unable to find user space address edbe201 in read_poison
> > Memory failure: tk->addr = 7f3cf3601000
> > Memory failure: address edbe201: call dev_pagemap_mapping_shift
> > Memory failure: tk->size_shift = 21
> > Memory failure: 0xedbe201: forcibly killing read_poison:22434 because of failure to unmap corrupted page
> >   => to deliver SIGKILL
> > Memory failure: 0xedbe201: Killing read_poison:22434 due to hardware memory corruption
> >   => to deliver SIGBUS
> >
> > Signed-off-by: Jane Chu <jane.chu@oracle.com>
> > ---
> >  mm/memory-failure.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index d9cc660..7038abd 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -315,7 +315,6 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
> >
> >         if (*tkc) {
> >                 tk = *tkc;
> > -               *tkc = NULL;
> >         } else {
> >                 tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
> >                 if (!tk) {
> > @@ -331,16 +330,21 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
> >                 tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
> >
> >         /*
> > -        * In theory we don't have to kill when the page was
> > -        * munmaped. But it could be also a mremap. Since that's
> > -        * likely very rare kill anyways just out of paranoia, but use
> > -        * a SIGKILL because the error is not contained anymore.
> > +        * Indeed a page could be mmapped N times within a process. And it's possible
> > +        * that not all of those N VMAs contain valid mapping for the page. In which
> > +        * case we don't want to send SIGKILL to the process on behalf of the VMAs
> > +        * that don't have the valid mapping, because doing so will eclipse the SIGBUS
> > +        * delivered on behalf of the active VMA.
> >          */
> >         if (tk->addr == -EFAULT || tk->size_shift == 0) {
> >                 pr_info("Memory failure: Unable to find user space address %lx in %s\n",
> >                         page_to_pfn(p), tsk->comm);
> > -               tk->addr_valid = 0;
> > +               if (tk != *tkc)
> > +                       kfree(tk);
> > +               return;

The immediate return bypasses list_add_tail() below, so we might lose
the chance of sending SIGBUS to the process.

tk->size_shift is always non-zero for !is_zone_device_page(), so
"tk->size_shift == 0" effectively checks "no mapping on ZONE_DEVICE" now.
As you mention above, "no mapping" doesn't means "invalid address"
so we can drop "tk->size_shift == 0" check from this if-statement.
Going forward in this direction, "tk->addr_valid == 0" is equivalent to
"tk->addr == -EFAULT", so we seems to be able to remove ->addr_valid.
This observation leads me to the following change, does it work for you?

  --- a/mm/memory-failure.c
  +++ b/mm/memory-failure.c
  @@ -199,7 +199,6 @@ struct to_kill {
   	struct task_struct *tsk;
   	unsigned long addr;
   	short size_shift;
  -	char addr_valid;
   };
   
   /*
  @@ -324,7 +323,6 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
   		}
   	}
   	tk->addr = page_address_in_vma(p, vma);
  -	tk->addr_valid = 1;
   	if (is_zone_device_page(p))
   		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
   	else
  @@ -336,11 +334,9 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
   	 * likely very rare kill anyways just out of paranoia, but use
   	 * a SIGKILL because the error is not contained anymore.
   	 */
  -	if (tk->addr == -EFAULT || tk->size_shift == 0) {
  +	if (tk->addr == -EFAULT)
   		pr_info("Memory failure: Unable to find user space address %lx in %s\n",
   			page_to_pfn(p), tsk->comm);
  -		tk->addr_valid = 0;
  -	}
   	get_task_struct(tsk);
   	tk->tsk = tsk;
   	list_add_tail(&tk->nd, to_kill);
  @@ -366,7 +362,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
   			 * make sure the process doesn't catch the
   			 * signal and then access the memory. Just kill it.
   			 */
  -			if (fail || tk->addr_valid == 0) {
  +			if (fail || tk->addr == -EFAULT) {
   				pr_err("Memory failure: %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
   				       pfn, tk->tsk->comm, tk->tsk->pid);
   				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,

> >         }
> > +       if (tk == *tkc)
> > +               *tkc = NULL;
> >         get_task_struct(tsk);
> >         tk->tsk = tsk;
> >         list_add_tail(&tk->nd, to_kill);
> 
> 
> Concept and policy looks good to me, and I never did understand what
> the mremap() case was trying to protect against.
> 
> The patch is a bit difficult to read (not your fault) because of the
> odd way that add_to_kill() expects the first 'tk' to be pre-allocated.
> May I ask for a lead-in cleanup that moves all the allocation internal
> to add_to_kill() and drops the **tk argument?

I totally agree with this cleanup. Thanks for the comment.

Thanks,
Naoya Horiguchi
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
