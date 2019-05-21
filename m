Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9205F24692
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 06:14:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B984E212746DD;
	Mon, 20 May 2019 21:14:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3F3A5212746D8
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 21:14:29 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCFDDC057E65;
 Tue, 21 May 2019 04:14:28 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0245600C6;
 Tue, 21 May 2019 04:14:28 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id B2B924A460;
 Tue, 21 May 2019 04:14:28 +0000 (UTC)
Date: Tue, 21 May 2019 00:14:28 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Jane Chu <jane.chu@oracle.com>
Message-ID: <255137178.29997735.1558412068338.JavaMail.zimbra@redhat.com>
In-Reply-To: <1558403523-22079-1-git-send-email-jane.chu@oracle.com>
References: <1558403523-22079-1-git-send-email-jane.chu@oracle.com>
Subject: Re: [PATCH v2] mm, memory-failure: clarify error message
MIME-Version: 1.0
X-Originating-IP: [10.67.116.97, 10.4.195.29]
Thread-Topic: mm, memory-failure: clarify error message
Thread-Index: 1DbEf0kdw7K8egROywjW6H/tEghkdQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 21 May 2019 04:14:28 +0000 (UTC)
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
Cc: linux-mm@kvack.org, n-horiguchi@ah.jp.nec.com, linux-kernel@vger.kernel.org,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


> Some user who install SIGBUS handler that does longjmp out
> therefore keeping the process alive is confused by the error
> message
>   "[188988.765862] Memory failure: 0x1840200: Killing
>    cellsrv:33395 due to hardware memory corruption"
> Slightly modify the error message to improve clarity.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc8b517..c4f4bcd 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -216,7 +216,7 @@ static int kill_proc(struct to_kill *tk, unsigned long
> pfn, int flags)
>          short addr_lsb = tk->size_shift;
>          int ret;
>  
> -        pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory
> corruption\n",
> +        pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware
> memory corruption\n",
>                  pfn, t->comm, t->pid);
>  
>          if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
> --
> 1.8.3.1

This error message is helpful.

Acked-by: Pankaj Gupta <pagupta@redhat.com>

> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
