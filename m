Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D87D17FFE9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Mar 2020 15:13:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D513F10FC361A;
	Tue, 10 Mar 2020 07:13:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com; envelope-from=miklos@szeredi.hu; receiver=<UNKNOWN> 
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E6D1310FC3619
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 07:13:53 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h8so12899927iob.2
        for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYU1wxb/ge5DirIWwK28AnywpJQY3e/U9vYLjiccLeo=;
        b=VUMeVtRyDXOmmJAxS6+A2yYelERcpsMobnU+K+HXqAre31LWH5Ybg9m1IevwykOAC8
         LuhKNNqsEpPoC+7agcvG1rpEStM2V2YpmRpy+BjS+BXwOrIaMeNotiWCXzqWdLczA50g
         BSV6AlSgpI8eO6i/dsioSkintiC6wBXLVK/So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYU1wxb/ge5DirIWwK28AnywpJQY3e/U9vYLjiccLeo=;
        b=Pd0Mdf6/G3XjgnTtcb8/DLSLAkqsFEY/wRu1PYHIQOHjDlPAJldC096KDTk0ehw2N1
         rvGo36NKVojqenaHlyrPk/gco+EmX7z/wG75/bu/6tOLDNA5bXXhQ71yQumE0na1C7tE
         l5UZBMeYZ8u71k+xdPvj2vNhBZ+75xnkKVlkVLjGdJjTmjWTjvcxDqHla6RDwqqNANnl
         fpyVOCd/akiwf81LYryXij0D5cutWEoKWsqZmiSOLdlzuOZ+SC/Hs/m54fvGrDxOzE+2
         wF44qgAQfHPRRspx78K2K6HVLcqY4D/Gx55ky5tPcM/eg4xV4OTeNC9k+167cOgWAR/p
         yWgw==
X-Gm-Message-State: ANhLgQ2nb9OCLC+T0wCsrtGSSFJA7EWgEhJK8E7+QC5hVa6HybFbKs/K
	RvWJzZc4/XwOYkbIvMBhmERsnfeIVEVloawsQUJYyw==
X-Google-Smtp-Source: ADFU+vt4UJTT+vs/UI2ECs5CVHI9EXdfAc9QZZ6Sp885Ay5Ze3oaL6r9lcZCZ0eNm46t4uWRe96k4C0dQKTFbWt2E9E=
X-Received: by 2002:a5d:934d:: with SMTP id i13mr17966092ioo.154.1583849582112;
 Tue, 10 Mar 2020 07:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-8-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-8-vgoyal@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 10 Mar 2020 15:12:51 +0100
Message-ID: <CAJfpeguxR2mR53BHEaSQUq2dN6mUVQHMVCoECrCX1F6x38M-0A@mail.gmail.com>
Subject: Re: [PATCH 07/20] fuse: Get rid of no_mount_options
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: WJDDGJYYUWFPKQCZS4X2A6EBMZYYCW4C
X-Message-ID-Hash: WJDDGJYYUWFPKQCZS4X2A6EBMZYYCW4C
X-MailFrom: miklos@szeredi.hu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WJDDGJYYUWFPKQCZS4X2A6EBMZYYCW4C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> This option was introduced so that for virtio_fs we don't show any mounts
> options fuse_show_options(). Because we don't offer any of these options
> to be controlled by mounter.
>
> Very soon we are planning to introduce option "dax" which mounter should
> be able to specify. And no_mount_options does not work anymore. What
> we need is a per mount option specific flag so that fileystem can
> specify which options to show.
>
> Add few such flags to control the behavior in more fine grained manner
> and get rid of no_mount_options.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
