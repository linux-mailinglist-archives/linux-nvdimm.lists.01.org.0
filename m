Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCC917FFD7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Mar 2020 15:10:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 881B710FC3617;
	Tue, 10 Mar 2020 07:11:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::144; helo=mail-il1-x144.google.com; envelope-from=miklos@szeredi.hu; receiver=<UNKNOWN> 
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 873F310FC35BE
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 07:11:06 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p1so8096900ils.12
        for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Dq64x4DjoKFCRaWP0RmVXxQ/yypMvRHHigI32DgfmA=;
        b=IMSgfzJYgymp5J//NAnPuXmv+ttIDEmyfzo3Bl/xD5bXo890r/Y+o2KMqeTHJlcpRr
         LHhWPmBfOOouLuWuT3Uj7HRvFT2ydIXCkZaFwsKzywxSWuEKNBetWQvDVoULEZEDm03p
         tRMUsriMnv8JkVwffZVVKi89BSYtpcGRODjq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Dq64x4DjoKFCRaWP0RmVXxQ/yypMvRHHigI32DgfmA=;
        b=sBaPa2VXwX0/AO57DFkAPrNCEY7DZlY/O1VoQAuqwi12pI92GA43dDpM43AA/vO6y8
         RsfpHX2Rds7Big9LfbXX8+E5v52j4PiydFAsiYIj6w+eRnugZx8KFXb70jtIpUvYUrRh
         bAWKwG/jby4L9qv4jl8S6E08kKPpT3EASibOQ3aU/fQqsBp0SCVKSAc3Zprh6pjbQ2ao
         qr5Dhn+luJbuZYko5P0ncEFLja5WLclcjufP1jJABYHjcXJexeBPFamsMZz5U8zCuNYm
         sz5WXYeP7Op2Yr+Mf++WBfIvhg0nG+tsZx8cF6kDshXBKyuMCBYFzivhmL9jRmnYL+cW
         /G5w==
X-Gm-Message-State: ANhLgQ10JN+3PwxEC63fjvmnYUP2vmNiQ6MjxkOCPC4d6bEk4zRSgtg1
	zFmmctaa6lR+2m4nGHCUEOn7GfFbcQJE4Qh4Wi2nkQ==
X-Google-Smtp-Source: ADFU+vtA2bBrA3QBgj3ZymF37VCxe3Znyz4vcji09X2nGjZ9/L3vfB4trInJdMsBR57HttHenvzZDwFXg1DyS7Avj/4=
X-Received: by 2002:a92:aa87:: with SMTP id p7mr12249562ill.63.1583849414997;
 Tue, 10 Mar 2020 07:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-7-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-7-vgoyal@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 10 Mar 2020 15:10:04 +0100
Message-ID: <CAJfpegvKRt6eaZHzs3e70y_c6j5q30jAir6k-hOWevWiQUOVKw@mail.gmail.com>
Subject: Re: [PATCH 06/20] virtiofs: Provide a helper function for virtqueue initialization
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: NJJUQIIP4ALZKV3ZQASHZWP5EOBPM7WN
X-Message-ID-Hash: NJJUQIIP4ALZKV3ZQASHZWP5EOBPM7WN
X-MailFrom: miklos@szeredi.hu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NJJUQIIP4ALZKV3ZQASHZWP5EOBPM7WN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> This reduces code duplication and make it little easier to read code.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
