Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9245938015B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 May 2021 02:58:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E1428100EAAF0;
	Thu, 13 May 2021 17:58:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 74FF9100F2245
	for <linux-nvdimm@lists.01.org>; Thu, 13 May 2021 17:58:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s6so32866756edu.10
        for <linux-nvdimm@lists.01.org>; Thu, 13 May 2021 17:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEpqh0+EO79bqyW92GQVGh/KezzVRI3iqRzND7tXdzE=;
        b=VyF5KAItiyhVUDoQPuSpn+6qkikMk2hl7TC6nDAY80mlI9Pwy7//OIK5bwd8VWGAjs
         LUoreoxokhhvpsC25SgrDuwwdLCMzPghiNv3kOqWghcYl5s19lLz86umn84/uvFpCKn7
         n6j5Kjexq6ICXKWPVLPeY+Z0gp6cI4cx1JQy0lAmT8rvNRbRqn48xIqLSlwSGZTVWCQq
         rxE36ApIMC0sHpYnPcGGFDjlGk/HSZSYK5zf2Hf04Up+ZKs4cUiUAMxCnVpvmwmOSZy9
         U8aW8T72WmOxPlXTzQGozkxhMI8VANb8asaEs4wrZHB2dNGDeoSdVls4rCw/oBbn3Pb7
         k5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEpqh0+EO79bqyW92GQVGh/KezzVRI3iqRzND7tXdzE=;
        b=KzVgIyATGca9emXscq1+nysH4GWy3QILDrIYobiqpZq5Ot2/zUC4izf4khM6qydl8n
         sVZ0C32VU4QKmVxb2Mu7DMtIpwB+BIZnEfLQzyR9Nl1SIIsjVWMYaANHP0U6UW3fuM0c
         9lFGTlGRBer6XqEjhtV/VWjhBDtAkC6hJ2SoHTF7CbyL23Lt3tyd+EORiODQacfIaveZ
         qCinQ/AggkyOOcJTN801oTuSU+9r4hAdMddZSx3smh9nqmuwkBucmP4KmF0HutqPjYIN
         FvVrdbHTwKVbXhHA+Jn+WQ53TTx1hTCKU5FCiBu4PClW4xGc9FCzsiYDRtqYUF5YruNV
         OBHA==
X-Gm-Message-State: AOAM531RftwSOZlgRbvHFTOBCOOe2dTVFjN3rIwpUwkChpPZAwStYPtY
	2X01VooW0JtkOYGdeySHfonGOTfdTgC4v9tojWScHKm4Z+8=
X-Google-Smtp-Source: ABdhPJzh0giSiEG3dqURONhskurpZE+LPObxwoKMA9HM9nAfG4jEWbjEzfSMDxLImnc7mtMejPt2UnMYiX/bADUi9Qs=
X-Received: by 2002:a05:6402:54e:: with SMTP id i14mr54897192edx.210.1620953925739;
 Thu, 13 May 2021 17:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <161898872871.3406469.4054282559340528393.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161898872871.3406469.4054282559340528393.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 May 2021 17:58:37 -0700
Message-ID: <CAPcyv4jgkAze76c6TNJ1_OKM91xjH0c_UHpsYsvaLcw6-APGrA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move nvdimm mailing list
To: linux-nvdimm <linux-nvdimm@lists.01.org>
Message-ID-Hash: 3J5CD7R5RDM7AIS67JVERNMRCP6CQ4GO
X-Message-ID-Hash: 3J5CD7R5RDM7AIS67JVERNMRCP6CQ4GO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, nvdimm@lists.linux.dev, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3J5CD7R5RDM7AIS67JVERNMRCP6CQ4GO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 21, 2021 at 12:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> After seeing some users have subscription management trouble, more spam
> than other Linux development lists, and considering some of the benefits
> of kernel.org hosted lists, nvdimm and persistent memory development is
> moving to nvdimm@lists.linux.dev.
>
> The old list will remain up until v5.14-rc1 and shutdown thereafter.
>

Events have transpired that require this schedule be expedited. So
once this patch ships in v5.13-rc2 the linux-nvdimm@lists.01.org list
will be shutdown and all future nvdimm correspondence must be sent to
nvdimm@lists.linux.dev.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
