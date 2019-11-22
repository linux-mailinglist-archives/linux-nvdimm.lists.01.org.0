Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AA6107655
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 Nov 2019 18:22:10 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1DEA910113300;
	Fri, 22 Nov 2019 09:22:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 37D54100DC406
	for <linux-nvdimm@lists.01.org>; Fri, 22 Nov 2019 09:22:30 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id v138so7151317oif.6
        for <linux-nvdimm@lists.01.org>; Fri, 22 Nov 2019 09:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpMumZh7hM/zRz5ImXsEU+Ekdm/GLWPGQ1iWkQqoBnI=;
        b=YkJrzs10Gt6V4yg1U01XTMx1xWgO54rfvRl5krEkDhjzwcLHLqwyXaEBvomS7Oi0FK
         yp5EnLK9hwtbZo1i3bB7e4o565qkBVUi2tidnmK8Tiif/B6NGPVkixZR1P/SQLkmmYDA
         Wu7ufZp33oAspBZy+0QH+Pay4PxQrScM/26QK2Qh2N2gjRYjRL04mvYxw9Q0+vOl0MV0
         Wm/iv7zZIbQRZZa015zu/C8P2KFeQ3H9TTZnnHHnZkScKQK/51YXlTX/7TJiF+UZox+J
         3XTu7sd9aJPFsz+gR8Q9AKMrAsvGFxTE32FOicihGdiGUTU8hz1ywCCOjRB0+FdLX5K0
         HYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpMumZh7hM/zRz5ImXsEU+Ekdm/GLWPGQ1iWkQqoBnI=;
        b=KzZ2W/83ed7tGG7EuQ/BQSwBbSswVTt3YAJxgNfV64G2H/+qCSpMho/k+p/O+X/S6o
         4oGixnAYJI6ExUNt/SIlc1L978vJ6kcUnqqdxqMCUkal6FCeW0sO68lIZokWpge6LuxP
         D/Hd7z55ohaNUY9kP5+99nQs1wc12rtFdw6BAh8mJbFWSG7WjVFTp0RymhXOAYX8a9R4
         KtcLKVhpI840tjDXXXS/+uFh3s1FGA4WBiIm1K8cOlIibPHXcrSkPJzKgDYN3OZPMlPf
         PnH/JCvghtZDwviLZc+gOlt5O8ah8c4J3UNDAQFXw9ljyb78SYMz0D8UjFj9Hd6gPyj5
         yDCA==
X-Gm-Message-State: APjAAAXgkAZUDcGPMVInbEeCioC2+qGOhAJBtbZzVhPNALheauP/sn2C
	EcbdkbTVYhnuA+nEz8uvRxxyT+tNstGLC5WikwVi0g==
X-Google-Smtp-Source: APXvYqwWzGTwo+k6GgV3qlbcGeYf/M3xynFpOZeAoDaWkvgp8kanJJWV5vV5Sr0B2ka7zWnNIiixEP7Yc2ypwvCrT9Q=
X-Received: by 2002:aca:ea57:: with SMTP id i84mr12679377oih.73.1574443324487;
 Fri, 22 Nov 2019 09:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20191122162644.27078-1-kbusch@kernel.org>
In-Reply-To: <20191122162644.27078-1-kbusch@kernel.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 22 Nov 2019 09:21:53 -0800
Message-ID: <CAPcyv4jvEJXwyGDRoK0tdRcbawVSPWB-4_=6MTohfM4OJwCK9g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Keith from NVDIMM maintainers
To: Keith Busch <kbusch@kernel.org>
Message-ID-Hash: OXF2NFTTKIDXB2U2SNGTTZKBSCSGADQH
X-Message-ID-Hash: OXF2NFTTKIDXB2U2SNGTTZKBSCSGADQH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OXF2NFTTKIDXB2U2SNGTTZKBSCSGADQH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 22, 2019 at 8:26 AM Keith Busch <kbusch@kernel.org> wrote:
>
> I no longer work in this capacity for the NVDIMM or DAX subsystems.

Thanks Keith, in more ways than one.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
