Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D652EA6D2
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Jan 2021 10:00:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A170100EBBBD;
	Tue,  5 Jan 2021 01:00:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 21618100ED49C
	for <linux-nvdimm@lists.01.org>; Tue,  5 Jan 2021 01:00:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g24so30243140edw.9
        for <linux-nvdimm@lists.01.org>; Tue, 05 Jan 2021 01:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tr+qoisVqhroSZauMDsZ+3eAYfKr9Fyv79GijuKfgfA=;
        b=IzrODVkVxLhCmGNQMrtfEdjlbxv4JICh+Xo6cEJ5jLsXoLYZRRbDu64+i31TO1vAGR
         bGhB2Nct4HWE+9hgZGCZVY1s7iX4kjx4iiE/8AdpP2zZOBk0un01cDM9A4gOENbNv9HL
         fehYo3lQB3mLXvbTQ9hLSp9suxTwPNo0gO4uwmFSR3MW3XO4XGLYwNrYBRFLCBLwdLfP
         rHMRj/iUIxg82jzLw524iSfj8JEvYGx294yHifAoI/HNf86fqeMChChq84zlrqvxg7HM
         F48O47wPj08vRgbm2T9QMVfGiwhOZdROrGLLLuvMqkUL6R5wnpJ0Miiz7UfEhJlbT7EN
         ktoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tr+qoisVqhroSZauMDsZ+3eAYfKr9Fyv79GijuKfgfA=;
        b=NTwkRy0bUOfPxyL3Qt5ZW33+bOj/EFpVURyjJDPuIcCAQR75waoibDb4hjGy9/FQJs
         omwIUYn0+FrCCjldIkXGiMkXoEl8tlQn5gurhIm1GgDrvtTE181koLlsiSA9CX38hKto
         4ew8+bN1Bc0lUgcnuB8R4XeBlDrzialLSOfUF2tWTnNNYv6HAKPppFCPjMkLo+wSD80k
         cSrYnHf5866beKhwygZT3O4Inbp7ph+EqybGVNnA26DN/R41VOoqVq+9GjOgfw6aj7nV
         s0tg1rPZUNtXZzhasfJZYEbesPyQJMwYZekXSRaAbOqIfyFIQR+FNE6oTBYnVMzRhPbw
         06nw==
X-Gm-Message-State: AOAM530Upxr5uSDajpNTdSQhm57RTWtlb1SIo4ePZTNmh97XlIcil/Lp
	vUF6Qp6uZIAELY0Clm2R1Xl2JyR0TDASdgwfp4N44g==
X-Google-Smtp-Source: ABdhPJyGlZ1Q6pLrvLI8M/Sg9/AAhX1n9GClTWA99jGmSGqtmBATGqJs+l+81LBcETRpraIF7c4ZPxj5rjUIF8Pe3aA=
X-Received: by 2002:a05:6402:1102:: with SMTP id u2mr44960900edv.18.1609837209119;
 Tue, 05 Jan 2021 01:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20201229002635.42555-1-jianpeng.ma@intel.com>
In-Reply-To: <20201229002635.42555-1-jianpeng.ma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 5 Jan 2021 01:00:02 -0800
Message-ID: <CAPcyv4i_HYByH9pLnuZgMgpRW=VkP=FGGStWodko1J5b4mbD+g@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm/pmem: remove unused header.
To: Jianpeng Ma <jianpeng.ma@intel.com>
Message-ID-Hash: 3DBRTCX25QMTJ3DLVW74M4TITOLLWDA5
X-Message-ID-Hash: 3DBRTCX25QMTJ3DLVW74M4TITOLLWDA5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3DBRTCX25QMTJ3DLVW74M4TITOLLWDA5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 28, 2020 at 4:44 PM Jianpeng Ma <jianpeng.ma@intel.com> wrote:
>
> 'commit a8b456d01cd6 ("bdi: remove BDI_CAP_SYNCHRONOUS_IO")' forgot
> remove the related header file.
>
> Fixes: a8b456d01cd6 ("bdi: remove BDI_CAP_SYNCHRONOUS_IO")
> Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
> ---

Applied, thanks, I'll manually drop the Fixes: tag.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
