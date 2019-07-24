Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C015F7424B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Jul 2019 01:45:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E1510212DC5DE;
	Wed, 24 Jul 2019 16:47:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=114.179.232.161; helo=tyo161.gate.nec.co.jp;
 envelope-from=n-horiguchi@ah.jp.nec.com; receiver=linux-nvdimm@lists.01.org 
Received: from tyo161.gate.nec.co.jp (tyo161.gate.nec.co.jp [114.179.232.161])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9E142212DC5D1
 for <linux-nvdimm@lists.01.org>; Wed, 24 Jul 2019 16:47:39 -0700 (PDT)
Received: from mailgate02.nec.co.jp ([114.179.233.122])
 by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x6ONj90V029079
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 25 Jul 2019 08:45:09 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x6ONj9Vd028359;
 Thu, 25 Jul 2019 08:45:09 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x6ONe3aT011021;
 Thu, 25 Jul 2019 08:45:09 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by
 mail02.kamome.nec.co.jp with ESMTP id BT-MMP-7087570;
 Thu, 25 Jul 2019 08:43:26 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Thu,
 25 Jul 2019 08:43:25 +0900
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v2 1/1] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS if mmaped more than once
Thread-Topic: [PATCH v2 1/1] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS if mmaped more than once
Thread-Index: AQHVQnAjSKtp5HUwfEeIsgIKjFcsrqbZ12MA
Date: Wed, 24 Jul 2019 23:43:25 +0000
Message-ID: <20190724234318.GA21820@hori.linux.bs1.fc.nec.co.jp>
References: <1564007603-9655-1-git-send-email-jane.chu@oracle.com>
 <1564007603-9655-2-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1564007603-9655-2-git-send-email-jane.chu@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-ID: <1F5511DB107F864C919C1A6A91C4628E@gisp.nec.co.jp>
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
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 24, 2019 at 04:33:23PM -0600, Jane Chu wrote:
> Mmap /dev/dax more than once, then read the poison location using address
> from one of the mappings. The other mappings due to not having the page
> mapped in will cause SIGKILLs delivered to the process. SIGKILL succeeds
> over SIGBUS, so user process looses the opportunity to handle the UE.
> 
> Although one may add MAP_POPULATE to mmap(2) to work around the issue,
> MAP_POPULATE makes mapping 128GB of pmem several magnitudes slower, so
> isn't always an option.
> 
> Details -
> 
> ndctl inject-error --block=10 --count=1 namespace6.0
> 
> ./read_poison -x dax6.0 -o 5120 -m 2
> mmaped address 0x7f5bb6600000
> mmaped address 0x7f3cf3600000
> doing local read at address 0x7f3cf3601400
> Killed
> 
> Console messages in instrumented kernel -
> 
> mce: Uncorrected hardware memory error in user-access at edbe201400
> Memory failure: tk->addr = 7f5bb6601000
> Memory failure: address edbe201: call dev_pagemap_mapping_shift
> dev_pagemap_mapping_shift: page edbe201: no PUD
> Memory failure: tk->size_shift == 0
> Memory failure: Unable to find user space address edbe201 in read_poison
> Memory failure: tk->addr = 7f3cf3601000
> Memory failure: address edbe201: call dev_pagemap_mapping_shift
> Memory failure: tk->size_shift = 21
> Memory failure: 0xedbe201: forcibly killing read_poison:22434 because of failure to unmap corrupted page
>   => to deliver SIGKILL
> Memory failure: 0xedbe201: Killing read_poison:22434 due to hardware memory corruption
>   => to deliver SIGBUS
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Suggested-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> ---
>  mm/memory-failure.c | 62 ++++++++++++++++++++++-------------------------------
>  1 file changed, 26 insertions(+), 36 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d9cc660..bd4db33 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -199,7 +199,6 @@ struct to_kill {
>  	struct task_struct *tsk;
>  	unsigned long addr;
>  	short size_shift;
> -	char addr_valid;
>  };
>  
>  /*
> @@ -304,43 +303,43 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>  /*
>   * Schedule a process for later kill.
>   * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
> - * TBD would GFP_NOIO be enough?
>   */
>  static void add_to_kill(struct task_struct *tsk, struct page *p,
>  		       struct vm_area_struct *vma,
> -		       struct list_head *to_kill,
> -		       struct to_kill **tkc)
> +		       struct list_head *to_kill)
>  {
>  	struct to_kill *tk;
>  
> -	if (*tkc) {
> -		tk = *tkc;
> -		*tkc = NULL;
> -	} else {
> -		tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
> -		if (!tk) {
> -			pr_err("Memory failure: Out of memory while machine check handling\n");
> -			return;
> -		}
> +	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
> +	if (!tk) {
> +		pr_err("Memory failure: Out of memory while machine check handling\n");
> +		return;

As Dan pointed out, the cleanup part can be delivered as a separate patch.

>  	}
> +
>  	tk->addr = page_address_in_vma(p, vma);
> -	tk->addr_valid = 1;
>  	if (is_zone_device_page(p))
>  		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
>  	else
>  		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
>  
>  	/*
> -	 * In theory we don't have to kill when the page was
> -	 * munmaped. But it could be also a mremap. Since that's
> -	 * likely very rare kill anyways just out of paranoia, but use
> -	 * a SIGKILL because the error is not contained anymore.
> +	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
> +	 * "tk->size_shift" is always non-zero for !is_zone_device_page(),
> +	 * so "tk->size_shift == 0" effectively checks no mapping on
> +	 * ZONE_DEVICE. Indeed, when a devdax page is mmapped N times
> +	 * to a process' address space, it's possible not all N VMAs
> +	 * contain mappings for the page, but at least one VMA does.
> +	 * Only deliver SIGBUS with payload derived from the VMA that
> +	 * has a mapping for the page.

OK, so SIGBUSs are sent M times (where M is the number of mappings
for the page). Then I'm convinced that we need "else if" block below.

Thanks,
Naoya Horiguchi

>  	 */
> -	if (tk->addr == -EFAULT || tk->size_shift == 0) {
> +	if (tk->addr == -EFAULT) {
>  		pr_info("Memory failure: Unable to find user space address %lx in %s\n",
>  			page_to_pfn(p), tsk->comm);
> -		tk->addr_valid = 0;
> +	} else if (tk->size_shift == 0) {
> +		kfree(tk);
> +		return;
>  	}
> +
>  	get_task_struct(tsk);
>  	tk->tsk = tsk;
>  	list_add_tail(&tk->nd, to_kill);
> @@ -366,7 +365,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
>  			 * make sure the process doesn't catch the
>  			 * signal and then access the memory. Just kill it.
>  			 */
> -			if (fail || tk->addr_valid == 0) {
> +			if (fail || tk->addr == -EFAULT) {
>  				pr_err("Memory failure: %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
>  				       pfn, tk->tsk->comm, tk->tsk->pid);
>  				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
> @@ -432,7 +431,7 @@ static struct task_struct *task_early_kill(struct task_struct *tsk,
>   * Collect processes when the error hit an anonymous page.
>   */
>  static void collect_procs_anon(struct page *page, struct list_head *to_kill,
> -			      struct to_kill **tkc, int force_early)
> +				int force_early)
>  {
>  	struct vm_area_struct *vma;
>  	struct task_struct *tsk;
> @@ -457,7 +456,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>  			if (!page_mapped_in_vma(page, vma))
>  				continue;
>  			if (vma->vm_mm == t->mm)
> -				add_to_kill(t, page, vma, to_kill, tkc);
> +				add_to_kill(t, page, vma, to_kill);
>  		}
>  	}
>  	read_unlock(&tasklist_lock);
> @@ -468,7 +467,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>   * Collect processes when the error hit a file mapped page.
>   */
>  static void collect_procs_file(struct page *page, struct list_head *to_kill,
> -			      struct to_kill **tkc, int force_early)
> +				int force_early)
>  {
>  	struct vm_area_struct *vma;
>  	struct task_struct *tsk;
> @@ -492,7 +491,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
>  			 * to be informed of all such data corruptions.
>  			 */
>  			if (vma->vm_mm == t->mm)
> -				add_to_kill(t, page, vma, to_kill, tkc);
> +				add_to_kill(t, page, vma, to_kill);
>  		}
>  	}
>  	read_unlock(&tasklist_lock);
> @@ -501,26 +500,17 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
>  
>  /*
>   * Collect the processes who have the corrupted page mapped to kill.
> - * This is done in two steps for locking reasons.
> - * First preallocate one tokill structure outside the spin locks,
> - * so that we can kill at least one process reasonably reliable.
>   */
>  static void collect_procs(struct page *page, struct list_head *tokill,
>  				int force_early)
>  {
> -	struct to_kill *tk;
> -
>  	if (!page->mapping)
>  		return;
>  
> -	tk = kmalloc(sizeof(struct to_kill), GFP_NOIO);
> -	if (!tk)
> -		return;
>  	if (PageAnon(page))
> -		collect_procs_anon(page, tokill, &tk, force_early);
> +		collect_procs_anon(page, tokill, force_early);
>  	else
> -		collect_procs_file(page, tokill, &tk, force_early);
> -	kfree(tk);
> +		collect_procs_file(page, tokill, force_early);
>  }
>  
>  static const char *action_name[] = {
> -- 
> 1.8.3.1
> 
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
