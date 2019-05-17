Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F34F2133B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 06:48:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57DBE2126D834;
	Thu, 16 May 2019 21:47:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=linux-nvdimm@lists.01.org 
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by ml01.01.org (Postfix) with ESMTP id AABF921945DE1
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 21:47:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 900E680D;
 Thu, 16 May 2019 21:47:55 -0700 (PDT)
Received: from [10.163.1.137] (unknown [10.163.1.137])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18AB33F5AF;
 Thu, 16 May 2019 21:47:52 -0700 (PDT)
Subject: Re: [PATCH] mm, memory-failure: clarify error message
To: Jane Chu <jane.chu@oracle.com>, n-horiguchi@ah.jp.nec.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1558066095-9495-1-git-send-email-jane.chu@oracle.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <512532de-4c09-626d-380f-58cef519166b@arm.com>
Date: Fri, 17 May 2019 10:18:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1558066095-9495-1-git-send-email-jane.chu@oracle.com>
Content-Language: en-US
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
Cc: linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>



On 05/17/2019 09:38 AM, Jane Chu wrote:
> Some user who install SIGBUS handler that does longjmp out

What the longjmp about ? Are you referring to the mechanism of catching the
signal which was registered ?

> therefore keeping the process alive is confused by the error
> message
>   "[188988.765862] Memory failure: 0x1840200: Killing
>    cellsrv:33395 due to hardware memory corruption"

Its a valid point because those are two distinct actions.

> Slightly modify the error message to improve clarity.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/memory-failure.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc8b517..14de5e2 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -216,10 +216,9 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>  	short addr_lsb = tk->size_shift;
>  	int ret;
>  
> -	pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory corruption\n",
> -		pfn, t->comm, t->pid);
> -
>  	if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
> +		pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory "
> +			"corruption\n", pfn, t->comm, t->pid);
>  		ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
>  				       addr_lsb, current);
>  	} else {
> @@ -229,6 +228,8 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>  		 * This could cause a loop when the user sets SIGBUS
>  		 * to SIG_IGN, but hopefully no one will do that?
>  		 */
> +		pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware "
> +			"memory corruption\n", pfn, t->comm, t->pid);
>  		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
>  				      addr_lsb, t);  /* synchronous? */

As both the pr_err() messages are very similar, could not we just switch between "Killing"
and "Sending SIGBUS to" based on a variable e.g action_[kill|sigbus] evaluated previously
with ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm).
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
