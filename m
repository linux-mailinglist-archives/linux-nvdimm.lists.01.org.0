Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D7A4160
	for <lists+linux-nvdimm@lfdr.de>; Sat, 31 Aug 2019 02:38:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A00F20251A21;
	Fri, 30 Aug 2019 17:40:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b31; helo=mail-yb1-xb31.google.com;
 envelope-from=tdteoenming@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 75C4D20216B6A
 for <linux-nvdimm@lists.01.org>; Fri, 30 Aug 2019 17:40:21 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c9so3121381ybf.2
 for <linux-nvdimm@lists.01.org>; Fri, 30 Aug 2019 17:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=IxBgIg4l69kyi9Pn+Z2YxWfpUanE7M6BW+hzJyfmhqM=;
 b=dunp+TSHsitYtx83NaiYgwojBQM0Hzhkg0usUNIL9Dp7+rtA5tcqXKc9BkG3b+CZ/l
 8ZMqXSIfwg8PoG9g4POs7s45f9w288sXmDfQyydogVWDHbzXkBRReBhynn2Esguj6JHm
 Yvsrjh9WRxfZ23T8BkzWuAFNsSEtjw6myPtdujqfJuwOzu5wBSPAL2Po1elLOPLInPvA
 AqvLJEP/zChKHbZ90H37N4YSLFP9I6pVFZGzJz42CYSPXcQHFjHEM2bAVbjXn25O1sNW
 qmOk+FUSkpAmQlP24iZPpHsU6ZKqjf/emy7Tp0VrcqZF1o8h0WrNRuZ5PvgSnpUFcYYd
 nQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=IxBgIg4l69kyi9Pn+Z2YxWfpUanE7M6BW+hzJyfmhqM=;
 b=knBBhcACTlIrP6+qQJ22Q11VCEwYbN/yf8kxUQWTLw4mG7qjwDKS7laRdIQQMxK5Z8
 be7vcwV8utfJNvLY57ehyy5HLNwFHz4cd2NB2UogO9RTxqyMrz8GVB3DKP7CnIVqybfB
 /VDVpD/6BMPcWQnFUT/KdgOjm2hETCMFUHiNd6pcE/Cz0vP40aqtd67ok9IljJvxUScD
 XsnFldgoYwQgq876w/JG+C3EnJm/hgDE50HzHI0O2wAByLhcsHHJIKnx6ifyGVPTWTCl
 0MmihBfULplLRGQqQ00ZyoI8/A43uRYEqKQGuG7JS9gqGzlrLKVwJfprx0XFHFIUjs6g
 oknA==
X-Gm-Message-State: APjAAAWCk83Nhcnz7ywYYtQtM8mmjNaljK5KVuiE9kUEYDCEKldsJmpH
 WvXSUUqnq5YjLJvLdL1HbU/NEx1xaJ6PWE4W3gLlLKk=
X-Google-Smtp-Source: APXvYqwFW89yb/3jfcCzzAUddYigYt3ppad4TUZixWueHN4yCDF9e0pbA2eDsy2s4xGuZVU0sE3VyO1oQ7fP7MhDuU4=
X-Received: by 2002:a25:1c6:: with SMTP id 189mr13005755ybb.200.1567211918194; 
 Fri, 30 Aug 2019 17:38:38 -0700 (PDT)
MIME-Version: 1.0
From: Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date: Sat, 31 Aug 2019 08:38:24 +0800
Message-ID: <CANnei0GD25YJC2tGZ91svsP4n5HAggMcHPheKowKQrQUjB5GTg@mail.gmail.com>
Subject: Singaporean Mr. Teo En Ming's Refugee Seeking Attempts, In The Search
 of a Substantially Better Life
To: linux-nvdimm@lists.01.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Subject: Singaporean Mr. Teo En Ming's Refugee Seeking Attempts, In
The Search of a Substantially Better Life

In reverse chronological order:

[1] Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday

Photo #1: At the building of the National Immigration Agency, Ministry
of the Interior, Taipei, Taiwan, 5th August 2019

Photo #2: Queue ticket no. 515 at the National Immigration Agency,
Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photo #3: Submission of documents/petition to the National Immigration
Agency, Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photos #4 and #5: Acknowledgement of Receipt (no. 03142) for the
submission of documents/petition from the National Immigration Agency,
Ministry of the Interior, Taipei, Taiwan, 5th August 2019, 10:00 AM

References:

(a) Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday (Blogspot blog)

Link: https://tdtemcerts.blogspot.sg/2019/08/petition-to-government-of-taiwan-for.html

(b) Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday (Wordpress blog)

Link: https://tdtemcerts.wordpress.com/2019/08/23/petition-to-the-government-of-taiwan-for-refugee-status/

[2] Application for Refugee Status at the United Nations Refugee
Agency, Bangkok, Thailand, 21st March 2017 Tuesday

References:

(a) [YOUTUBE] Vlog: The Road to Application for Refugee Status at the
United Nations High Commissioner for Refugees, Bangkok

Link: https://www.youtube.com/watch?v=utpuAa1eUNI

YouTube video Published on March 22nd, 2017

Views as at 31st August 2019: 593

YouTube Channel: Turritopsis Dohrnii Teo En Ming
Subscribers as at 31st August 2019: 2815
Link: https://www.youtube.com/channel/UC__F2hzlqNEEGx-IXxQi3hA






-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
