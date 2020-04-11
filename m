Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F8A1A4D5C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 Apr 2020 04:05:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF79310FC3619;
	Fri, 10 Apr 2020 19:06:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C566E10FC33FD
	for <linux-nvdimm@lists.01.org>; Fri, 10 Apr 2020 19:05:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i7so4532237edq.3
        for <linux-nvdimm@lists.01.org>; Fri, 10 Apr 2020 19:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqa9rY7it9s6rsqySHSDlF+aorLQqcLn41FSMJS0aQg=;
        b=c7h/ioo/gG+JTPbVmw2k3NGViH0tOlqB7NWyBXvLvlzkeUkjMCK/glEX2oUAj24HPq
         E5Qu0+rfCULMJRvb3E7kgU7xLz9o0qj3PMxgZha7wGEWH+JM4Pk5o+y0GRIWWxlyblN8
         f6XSgTR///DOBCQP2+6yYy6nBJbwqV0PhS5dUMJsKP7lQr+Fj0gQB0ihqvq026f/wgqi
         5+yRDF1gADT+xfVkLj3oD7X9qDG3Fbq40G9hClNbGqnAAz0ICzHGqVe4izyToIw9L6BD
         8wJfWax2wBFC8wiQACaEA6X/9xhXEG5Mg0Rn28RfvQb3xXWzPwR+e71P6+HFBw5y7dZS
         muJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqa9rY7it9s6rsqySHSDlF+aorLQqcLn41FSMJS0aQg=;
        b=fvxUI7AtdzlPf303N01CAohkUipKloXWO+n5zKEhujaZS7Me/KeKnLWA5yyRj9awg5
         ndG4hi10dXPJ4QQkzWUArkHlnpOQXhzGoT3FH1nd7XsMzHNWoEnl4CjNRX4B0KGAV+62
         Lm8Eo9pCNbGiI708sO8oEdHgGVdCbu1ilbDEmbqZuh+PgcHDS4KA0IGcF4bhhCK4OS+W
         OJz33zL5OhOlti0HXZLmNNtyNf1NwYoxjvXKvmCS8foCEHG+isIRuRgVYhdh/NYuEySm
         7FSW55xPFnhnIHcLRhmKsGweCMuxozjhfb+m5dkdIocGjoPtRkoSmhqMed95ZmGyS6mD
         X6Fw==
X-Gm-Message-State: AGi0PuY8NmnHpHjZTGrpeWNb91a6UUCoCpacV46MvdywlvyxMeTbuyWV
	TuT48dKASuN6D8EeZ3igAYE/kButjaw32n2MYbwZbg==
X-Google-Smtp-Source: APiQypIltsE51FxPYEj32NYn0GCvcruneHnyLqBqdOUh1ydgOjfSuMlqCMp1MHvK+XFdSr/t43ghMbgx2jbmespOGgo=
X-Received: by 2002:a05:6402:1b03:: with SMTP id by3mr7124589edb.93.1586570708478;
 Fri, 10 Apr 2020 19:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200411000916.13656-1-vishal.l.verma@intel.com>
In-Reply-To: <20200411000916.13656-1-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 Apr 2020 19:04:57 -0700
Message-ID: <CAPcyv4i6ZFKMAOyydUjoFW7O3JY6GXxHWC6dQa0ae6ujXE13Bg@mail.gmail.com>
Subject: Re: [PATCH] dax/kmem: refrain from adding memory into an impossible node
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: BUIDTGGACZUETXQK3DBVFJQ3E5625I5X
X-Message-ID-Hash: BUIDTGGACZUETXQK3DBVFJQ3E5625I5X
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BUIDTGGACZUETXQK3DBVFJQ3E5625I5X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 10, 2020 at 5:09 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> A misbehaving qemu created a situation where the ACPI SRAT table
> advertised one fewer proximity domains than intended. The NFIT table did
> describe all the expected proximity domains. This caused the device dax
> driver to assign an impossible target_node to the device, and when
> hotplugged as system memory, this would fail with the following
> signature:
>
>   [  +0.001627] BUG: kernel NULL pointer dereference, address: 0000000000000088
>   [  +0.001331] #PF: supervisor read access in kernel mode
>   [  +0.000975] #PF: error_code(0x0000) - not-present page
>   [  +0.000976] PGD 80000001767d4067 P4D 80000001767d4067 PUD 10e0c4067 PMD 0
>   [  +0.001338] Oops: 0000 [#1] SMP PTI
>   [  +0.000676] CPU: 4 PID: 22737 Comm: kswapd3 Tainted: G           O      5.6.0-rc5 #9
>   [  +0.001457] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>       BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>   [  +0.001990] RIP: 0010:prepare_kswapd_sleep+0x7c/0xc0
>   [  +0.000780] Code: 89 df e8 87 fd ff ff 89 c2 31 c0 84 d2 74 e6 0f 1f 44
>                       00 00 48 8b 05 fb af 7a 01 48 63 93 88 1d 01 00 48 8b
>                       84 d0 20 0f 00 00 <48> 3b 98 88 00 00 00 75 28 f0 80 a0
>                       80 00 00 00 fe f0 80 a3 38 20
>   [  +0.002877] RSP: 0018:ffffc900017a3e78 EFLAGS: 00010202
>   [  +0.000805] RAX: 0000000000000000 RBX: ffff8881209e0000 RCX: 0000000000000000
>   [  +0.001115] RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffff8881209e0e80
>   [  +0.001098] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000008000
>   [  +0.001092] R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000003
>   [  +0.001092] R13: 0000000000000003 R14: 0000000000000000 R15: ffffc900017a3ec8
>   [  +0.001091] FS:  0000000000000000(0000) GS:ffff888318c00000(0000) knlGS:0000000000000000
>   [  +0.001275] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [  +0.000882] CR2: 0000000000000088 CR3: 0000000120b50002 CR4: 00000000001606e0
>   [  +0.001095] Call Trace:
>   [  +0.000388]  kswapd+0x103/0x520
>   [  +0.000494]  ? finish_wait+0x80/0x80
>   [  +0.000547]  ? balance_pgdat+0x5a0/0x5a0
>   [  +0.000607]  kthread+0x120/0x140
>   [  +0.000508]  ? kthread_create_on_node+0x60/0x60
>   [  +0.000706]  ret_from_fork+0x3a/0x50
>
> Add a check in the kmem driver to ensure that the target_node for the
> device in question is in the nodes_possible mask.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/kmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 3d0a7e702c94..760c5b4e88c8 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -32,7 +32,7 @@ int dev_dax_kmem_probe(struct device *dev)
>          * unavoidable performance issues.
>          */
>         numa_node = dev_dax->target_node;
> -       if (numa_node < 0) {
> +       if (numa_node < 0 || !node_possible(numa_node)) {

Looks good.

Additionally, I think we should also fix this at the other end and
have the nfit driver validate that the proximity domain values that it
translates to numa nodes are in the possible set and if not fall back
to acpi_map_pxm_to_online_node() i.e. "if impossible fallback to
closest". That way this failing config will start working albeit with
the wrong numa node, but that's the firmware's problem. See the calls
to acpi_map_pxm_to_node() in drivers/acpi/nfit/core.c.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
