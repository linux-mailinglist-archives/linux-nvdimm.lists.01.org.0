Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E32DBAE9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 07:00:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3859D100ED49B;
	Tue, 15 Dec 2020 22:00:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8B864100ED499
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 22:00:30 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id j22so13026635eja.13
        for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 22:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FR5X88fegf8w0UuIVApL8BG0Iy1zSrKwV+m5ej9rErQ=;
        b=pcUOAL9L6nMIhGkoITjlm4bVCQUpzXo7PNb1cRp7pA84vYQExjZwfSexq7/qB9Hn0F
         72jjyjqle9z+ZW2N3Dinf6lE+CMRDpM5rnxpzdJP9dMtdsw7S5afJU+CaKBFFNLYNpaf
         vkMfasE7jzxBEYsyhQGFJ1ZbflOuNM2t1stDkjq9QNJtqZGc2ePFknhaFgwo4INGiHRQ
         yvZLgkYGYW6xC+pgDSwms11sPk99vDugmU8mkJi4FF6sUiLDS1aq86wCjmNpkjqwS1BR
         P7Kosamib8+LczNIrreG/JEBhL9EWBOzEE87zN9r6v7NEv0eLhGKBzzCu7D3WWAum/Zx
         LWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FR5X88fegf8w0UuIVApL8BG0Iy1zSrKwV+m5ej9rErQ=;
        b=KfcuKLKX6BvuJr8a38feKz+lpL505DVVV1P/X4aYSYOLROZ4H2LmOoEey8YqHEayFv
         hWbYWhYcaceyoJ3QYxtJsktSGYyBpMaPk4mW5SSlVXKcJx1op7pKF22DyAHhJ0bKui5J
         +rDzQpJhCndqH2gMC1hpR7gZo2YiJH1gm0EwJLtKUljYZT/xHZ3eMuYoklxmKmqmlo7c
         Bj0QuZQwRKRcc9DNVDU0SHb6yhZN+I4c03jI96fAT8S5GMMIJJz8fihU4vnz1zFBErQw
         b9v5qB8jvAOzwLpA2QMUrblH6YOGhVAPMpNqFXnVD+Dggx7lsvBCGvSh+kb4ADRsDh9y
         BQTw==
X-Gm-Message-State: AOAM533tAz832D3m0Fc7DlbLeCXlnQ5OV/TFQEGdqLvPbYOWjSXu46Hm
	l/QP6HziPETelZ51e8TCb5ICjxdu2WrXb3J63W8h7Q==
X-Google-Smtp-Source: ABdhPJwXBatXsBNnCwAYc+YWicFXF7XTdcX/WoVJv/PCGD8ozlSDeJQLyeOyEI3ZubEb19fMhGTkOXS5c7cwa12GLEE=
X-Received: by 2002:a17:906:a3c7:: with SMTP id ca7mr30729536ejb.523.1608098428423;
 Tue, 15 Dec 2020 22:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20201214134506.4831-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201214134506.4831-1-zhengyongjun3@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 15 Dec 2020 22:00:17 -0800
Message-ID: <CAPcyv4hKOk-00uc876m_UZdUEKNgdgPeew9LWSTT6ksgXn8Mqg@mail.gmail.com>
Subject: Re: [PATCH -next] dax: pmem: convert comma to semicolon
To: Zheng Yongjun <zhengyongjun3@huawei.com>
Message-ID-Hash: ARBQARISXOXG2JQF7KBDRVAJ75AD6ZYB
X-Message-ID-Hash: ARBQARISXOXG2JQF7KBDRVAJ75AD6ZYB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ARBQARISXOXG2JQF7KBDRVAJ75AD6ZYB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 14, 2020 at 5:45 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Thanks, applied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
